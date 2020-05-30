# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quotations::Create do
  describe '#call' do
    subject { described_class.new(params).call }

    let(:params) do
      {
        language: 'uk',
        page: 22,
        percent: 1,
        url: 'http://127.0.0.1:3000/some_url',
        text: 'lorem ipsum',
        scan: scan_params
      }
    end
    let(:scan_params) { nil }

    context 'without scan' do
      context 'valid params' do
        it { expect(subject.success?).to be_truthy }
        it { expect { subject }.to change { Quotation.count }.by(1) }
        it { expect(subject[:quotation].language).to eq(params[:language]) }
        it { expect(subject[:quotation].page).to eq(params[:page]) }
        it { expect(subject[:quotation].percent).to eq(params[:percent]) }
        it { expect(subject[:quotation].url).to eq(params[:url]) }
        it { expect(subject[:quotation].text).to eq(params[:text]) }
      end

      context 'not valid params' do
        let(:params) do
          { url: 'string' }
        end

        it { expect(subject.success?).to be_falsey }
        it { expect(subject.errors).to eq({ url: ['is invalid'] }) }
        it { expect { subject }.not_to change { Quotation.count } }

        context 'empty params' do
          let(:params) { {} }

          it { expect(subject.success?).to be_falsey }
          it { expect(subject.errors).to eq({ quotation: ['is empty'] }) }
        end
      end
    end

    context 'with scan' do
      context 'valid scan params' do
        let(:file_path) { Rails.root.join('spec', 'fixtures', 'quote.jpeg') }
        let(:image) { Rack::Test::UploadedFile.new file_path, 'image/jpeg' }
        let(:scan_params) do
          { image: image, do_not_scan: true }
        end

        it { expect(subject.success?).to be_truthy }
        it { expect { subject }.to change { Quotation.count }.by(1) }
        it { expect { subject }.to change { Scan.count }.by(1) }
      end

      context 'not valid scan params' do
        let(:scan_params) { { language: 'aaa' } }

        it { expect(subject.success?).to be_falsey }
        it { expect(subject.errors).to eq({ language: ['is the wrong length (should be 2 characters)'] }) }
        it { expect { subject }.not_to change { Quotation.count } }
        it { expect { subject }.not_to change { Scan.count } }
      end
    end
  end
end

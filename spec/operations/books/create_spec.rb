# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Books::Create do
  describe '#call' do
    subject { described_class.new(params, authors_params).call }

    let(:params) do
      {
        title: 'lorem ipsum',
      }
    end
    let(:authors_params) { nil }

    context 'valid params' do
      it { expect(subject.success?).to be_truthy }
      it { expect { subject }.to change { Book.count }.by(1) }
      it { expect(subject[:book].title).to eq(params[:title]) }

      context 'book exists' do
        let!(:book){ create :book }
        let(:params){{title: book.title}}

        it { expect { subject }.not_to change { Book.count } }
        it { expect(subject[:book]).to eq(book) }
      
        context 'books authors present' do
          let!(:book){ create :book, :with_author }
          let(:params){{title: book.title}}
      
          it { expect { subject }.not_to change { Book.count } }
          it { expect(subject[:book]).to eq(book) }    
        end

      end
    end

    context 'not valid params' do
      let(:params) do
        { title: 's' }
      end

      it { expect(subject.success?).to be_falsey }
      it { expect(subject.errors).to eq({ title: ['is too short (minimum is 2 characters)'] }) }
      it { expect { subject }.not_to change { Book.count } }

      context 'empty params' do
        let(:params) { {} }

        it { expect(subject.success?).to be_falsey }
        it { expect(subject.errors).to eq({ title: ['is too short (minimum is 2 characters)'] }) }
      end
    end

    context 'with authors' do
      let!(:author) { create(:author) }
      let(:authors_params) { [{ id: author.id }, { full_name: 'some name' }] }

      it { expect(subject[:book].authors.length).to eq(2) }

      it 'adds authors to the book' do
        expect(Authors::CreateCollection).to receive(:new).with(authors_params).and_call_original
        expect_any_instance_of(Authors::CreateCollection).to receive(:call).and_call_original

        subject
      end

      context 'book without author exists' do
        let!(:book){ create :book }
        let(:params){{title: book.title}}
        let(:authors_params) { [{ full_name: author.full_name }] }

        it { expect { subject }.to change { Book.count }.by(1) }
      end

      context 'book with author exists' do
        let!(:book){ create :book, authors: [author] }
        let(:params){{title: book.title}}
        let(:authors_params) { [{ full_name: author.full_name }] }

        it { expect { subject }.not_to change { Book.count } }
        it { expect(subject[:book]).to eq(book) }
      end
    end
  end
end

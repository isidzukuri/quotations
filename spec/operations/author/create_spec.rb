# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authors::Create do
  describe '#call' do
    subject { described_class.new(params).call }

    let(:params) do
      {
        full_name: 'Some Name'
      }
    end

    context 'valid params' do
      it { expect(subject.success?).to be_truthy }
      it { expect { subject }.to change { Author.count }.by(1) }
      it { expect(subject[:author].full_name).to eq(params[:full_name]) }
    end

    context 'not valid params' do
      let(:params) do
        { full_name: '1' }
      end

      it { expect(subject.success?).to be_falsey }
      it { expect(subject.errors).to eq({ full_name: ['is too short (minimum is 2 characters)'] }) }
      it { expect { subject }.not_to change { Author.count } }

      context 'empty params' do
        let(:params) { {} }

        it { expect(subject.success?).to be_falsey }
        it { expect(subject.errors).to eq({ full_name: ['is too short (minimum is 2 characters)'] }) }
      end
    end
  end
end

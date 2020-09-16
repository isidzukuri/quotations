# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authors::CreateCollection do
  describe '#call' do
    let!(:author){ create(:author) }

    subject { described_class.new(authors_params).call }

    context 'with id' do
      let(:authors_params) { [{id: author.id}] }
    
      it { expect { subject }.not_to change { Author.count } }
      it { expect(subject[:author_ids]).to eq([author.id]) }
    end

    context 'without id' do
      let(:authors_params) { [{full_name: 'some name'}] }
    
      it { expect { subject }.to change { Author.count }.by(1) }
      it { expect(subject[:author_ids].length).to eq(1) }
    
      context 'author with given name exists' do
        let(:authors_params) { [{full_name: author.full_name}] }
         
        it { expect { subject }.not_to change { Author.count } }
        it { expect(subject[:author_ids]).to eq([author.id]) }
      end
    end

    context 'invalid author' do
      let(:authors_params) { [{full_name: 's'}] }
    
      it { expect { subject }.not_to change { Author.count } }
      it { expect(subject[:author_ids]).to eq([]) }
    end

    context 'few authors' do
      let(:authors_params) { [{id: author.id}, {full_name: 'some name'}] }

      it { expect { subject }.to change { Author.count }.by(1) }
      it { expect(subject[:author_ids].length).to eq(2) }
    end
  end
end

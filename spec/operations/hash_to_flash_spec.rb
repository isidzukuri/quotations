# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HashToFlash do
  describe '#call' do
    let(:hash_object) do
      { some_attr: ['error 1', 'error 2'], other_attr: ['error 3', 'error 4'] }
    end

    subject! { described_class.new(hash_object).call }

    it { is_expected.to eq('some_attr:<br>- error 1<br>- error 2other_attr:<br>- error 3<br>- error 4') }
  end
end

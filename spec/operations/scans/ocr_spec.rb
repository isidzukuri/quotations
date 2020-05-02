# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scans::Ocr do
  describe '.call' do
    let(:scan) { create(:scan) }
    let(:text) { "\"If it still in your mind,\nit is worth\ntaking the risk.\"\n" }
    let(:api_key) { 'google_vision_api_key' }
    let(:request_url) { "https://vision.googleapis.com/v1/images:annotate?key=#{api_key}" }
    let(:vcr_cassette) { :google_vision_success }

    before do
      allow_any_instance_of(Scans::VisionClient).to receive(:request_url).and_return(request_url)
    end

    subject do
      VCR.use_cassette(vcr_cassette) do
        described_class.new.call(scan)
      end
    end

    it { expect { subject }.to change { scan.text }.to(text) }
    it { expect { subject }.to change { scan.status }.to('scanned') }

    context 'scanning fails' do
      let(:api_key) { 'invalid_api_key' }
      let(:vcr_cassette) { :google_vision_fail }

      it { expect { subject }.to raise_error(Scans::VisionClient::Error) }
    end
  end
end

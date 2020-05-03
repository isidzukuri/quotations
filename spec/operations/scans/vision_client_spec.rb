# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scans::VisionClient do
  describe '.call' do
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'quote.jpeg') }
    let(:image_base64) { Base64.strict_encode64(File.open(file_path).read) }
    let(:api_key) { 'google_vision_api_key' }
    let(:request_url) { "https://vision.googleapis.com/v1/images:annotate?key=#{api_key}" }
    let(:vcr_cassette) { :google_vision_success }

    before do
      allow_any_instance_of(described_class).to receive(:request_url).and_return(request_url)
    end

    subject do
      VCR.use_cassette(vcr_cassette) do
        described_class.new(image_base64).call
      end
    end

    it { expect(subject[:text]).to eq("\"If it still in your mind,\nit is worth\ntaking the risk.\"\n") }

    context 'request failed' do
      let(:api_key) { 'invalid_api_key' }
      let(:vcr_cassette) { :google_vision_failure }

      it { expect { subject }.to raise_error(Scans::VisionClient::Error) }
    end
  end
end

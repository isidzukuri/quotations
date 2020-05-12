# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scans::Create do
  describe 'POST #create' do
    let(:api_key) { 'google_vision_api_key' }
    let(:request_url) { "https://vision.googleapis.com/v1/images:annotate?key=#{api_key}" }
    let(:vcr_cassette) { :google_vision_success }
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'quote.jpeg') }
    let(:image) { Rack::Test::UploadedFile.new file_path, 'image/jpeg' }
    let(:text) { "\"If it still in your mind,\nit is worth\ntaking the risk.\"\n" }
    let(:do_not_scan) { false }
    let(:params) do
      { image: image, do_not_scan: do_not_scan }
    end

    before do
      allow_any_instance_of(Scans::VisionClient).to receive(:request_url).and_return(request_url)
    end

    subject do
      VCR.use_cassette(vcr_cassette) do
        described_class.new(params).call
      end
    end

    it { expect { subject }.to change { Scan.count }.by(1) }
    it { expect(subject[:scan].status).to eq('scanned') }
    it { expect(subject[:scan].text).to eq(text) }

    context 'do not scan' do
      let(:do_not_scan) { true }

      it { expect(subject[:scan].status).to eq('initialized') }
      it { expect(subject[:scan].text).to eq(nil) }
    end
  end
end

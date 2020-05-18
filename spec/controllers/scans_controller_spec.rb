# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScansController, type: :controller do
  describe 'GET #index' do
    let!(:scan) { create :scan }

    subject! { get :index }

    it { expect(assigns(:scans)).to eq [scan] }
    it { expect(response.status).to eq 200 }
    it { is_expected.to render_template(:index) }
  end

  describe 'GET #show' do
    let!(:scan) { create :scan }

    subject! { get :show, params: { id: scan.id } }

    it { expect(assigns(:scan)).to eq scan }
    it { expect(response.status).to eq 200 }
    it { is_expected.to render_template(:show) }
  end

  describe 'DELETE #destroy' do
    let!(:scan) { create :scan }

    subject { delete :destroy, params: { id: scan.id } }

    it { expect { subject }.to change { Scan.count }.by(-1) }
    it { expect(subject).to redirect_to scans_path }
  end

  describe 'POST #create' do
    let(:api_key) { 'google_vision_api_key' }
    let(:request_url) { "https://vision.googleapis.com/v1/images:annotate?key=#{api_key}" }
    let(:vcr_cassette) { :google_vision_success }
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'quote.jpeg') }
    let(:image) { Rack::Test::UploadedFile.new file_path, 'image/jpeg' }
    let(:text) { "\"If it still in your mind,\nit is worth\ntaking the risk.\"\n" }
    let(:do_not_scan) { false }
    let(:params) do
      { scan: { image: image, do_not_scan: do_not_scan } }
    end

    before do
      allow_any_instance_of(Scans::VisionClient).to receive(:request_url).and_return(request_url)
    end

    subject do
      VCR.use_cassette(vcr_cassette) do
        post(:create, params: params)
      end
    end

    it { expect { subject }.to change { Scan.count }.by(1) }
    it 'calls service object' do
      expect(Scans::Create).to receive(:new).and_call_original
      expect_any_instance_of(Scans::Create).to receive(:call).and_call_original

      subject
    end
  end
end

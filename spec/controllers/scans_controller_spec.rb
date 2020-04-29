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
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'quote.jpeg') }
    let(:image) { Rack::Test::UploadedFile.new file_path, 'image/jpeg' }
    let(:params) do
      { scan: { image: image } }
    end

    subject { post(:create, params: params) }

    it { expect { subject }.to change { Scan.count }.by(1) }
  end
end

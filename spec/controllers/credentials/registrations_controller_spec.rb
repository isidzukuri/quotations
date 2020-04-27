require 'rails_helper'

RSpec.describe Credentials::RegistrationsController, type: :controller do   
  describe 'POST create' do
    let(:params) do
      {
        credential: {
          email: 'dadsadsa@sdadsad.cc', 
          password: '123456', 
          password_confirmation: '123456'
        }
      }
    end

    subject { post(:create, params: params) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:credential]
    end

    it{ expect{ subject }.to change{ Credential.count }.by(1) }
    it{ expect{ subject }.to change{ User.count }.by(1) }
  end
end
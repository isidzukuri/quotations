# frozen_string_literal: true

module Credentials
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do
        User.create if resource.persisted?
      end
    end
  end
end

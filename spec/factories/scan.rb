# frozen_string_literal: true

FactoryBot.define do
  factory :scan do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'quote.jpeg'), 'image/jpeg') }
  end
end

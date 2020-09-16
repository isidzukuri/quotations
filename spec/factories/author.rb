# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    full_name { FFaker::Name.name }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { FFaker::Name.name }

    trait :with_author do
      authors { [create(:author)] }
    end
  end
end

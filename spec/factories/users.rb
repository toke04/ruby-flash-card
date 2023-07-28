# frozen_string_literal: true

FactoryBot.define do # admin権限のない、一般の利用ユーザーを想定
  factory :user do
    uid { rand(99999999).to_s }
    provider { 'github' }
    image { 'https://example.com/image'}
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end

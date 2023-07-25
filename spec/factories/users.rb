# frozen_string_literal: true

FactoryBot.define do # admin権限のない、一般の利用ユーザーを想定
  factory :user do
    uid { '22222222' }
    provider { 'github' }
    image { 'https://example.com/image'}
    admin { false }

    trait :admin do
      uid { '11111111' }
      admin { true }
    end
  end
end

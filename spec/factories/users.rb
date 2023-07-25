# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user, class: 'User' do
    uid { '11111111' }
    provider { 'github' }
    image { 'https://example.com/image'}
    admin { true }
  end

  # admin権限のない、一般の利用ユーザーを想定
  factory :normal_user, class: 'User' do
    uid { '22222222' }
    provider { 'github' }
    image { 'https://example.com/image'}
    admin { false }
  end
end

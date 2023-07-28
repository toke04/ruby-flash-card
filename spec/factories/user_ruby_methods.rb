# frozen_string_literal: true

FactoryBot.define do
  factory :user_zip_method, class: 'UserRubyMethod' do
    memo { 'レシーバーのインデックス番号に合わせて引数の配列を合体させて、配列を作成する' }
    remembered { false }
    association :user, factory: :user
    association :ruby_method, factory: :zip_method_of_array

    trait :remembered_true do
      remembered { true }
    end
  end

  factory :user_merge_method, class: 'UserRubyMethod' do
    memo { 'レシーバーと引数のハッシュを合体させて、新しいハッシュを作成する' }
    remembered { false }
    association :user, factory: :user
    association :ruby_method, factory: :merge_method_of_hash

    trait :remembered_true do
      remembered { true }
    end
  end
end

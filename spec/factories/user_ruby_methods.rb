FactoryBot.define do
  factory :user_zip_method, class: 'UserRubyMethod' do
    memo { 'レシーバーのインデックス番号に合わせて引数の配列を合体させて、配列を作成する' }
    association :user, factory: :normal_user
    association :ruby_method, factory: :zip_method
  end
end

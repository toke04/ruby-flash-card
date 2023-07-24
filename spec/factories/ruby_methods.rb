FactoryBot.define do
  factory :zip_method, class: 'RubyMethod' do
    name { 'zip' }
    official_url { 'https://docs.ruby-lang.org/ja/latest/method/Array/i/zip.html' }
    association :ruby_module, factory: :array_module
  end
end

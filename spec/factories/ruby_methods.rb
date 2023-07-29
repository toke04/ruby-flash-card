# frozen_string_literal: true

FactoryBot.define do
  factory :zip_method_of_array, class: 'RubyMethod' do
    name { 'zip' }
    official_url { 'https://docs.ruby-lang.org/ja/latest/method/Array/i/zip.html' }
    association :ruby_module, factory: :array_module
  end

  factory :merge_method_of_hash, class: 'RubyMethod' do
    name { 'merge' }
    official_url { 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/merge.html' }
    association :ruby_module, factory: :hash_module
  end

  factory :upcase_method_of_String, class: 'RubyMethod' do
    name { 'upcase' }
    official_url { 'https://docs.ruby-lang.org/ja/latest/method/String/i/upcase.html' }
    association :ruby_module, factory: :string_module
  end
end

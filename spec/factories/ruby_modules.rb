# frozen_string_literal: true

FactoryBot.define do
  factory :array_module, class: 'RubyModule' do
    name { 'Array' }
  end

  factory :hash_module, class: 'RubyModule' do
    name { 'Hash' }
  end

  factory :string_module, class: 'RubyModule' do
    name { 'String' }
  end
end

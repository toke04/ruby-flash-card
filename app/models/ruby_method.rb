# frozen_string_literal: true

class RubyMethod < ApplicationRecord
  has_many :user_ruby_methods, dependent: :destroy
  belongs_to :ruby_module

  validates :name, presence: true, uniqueness: true
  validates :official_url, presence: true
  # enum module: { Enumerable: 0, Array: 1, String: 2, Hash: 3, Dir: 4 }
  scope :user_methods_and_module, -> { includes(%i[user_ruby_methods ruby_module]) }

  scope :user_remembered, ->(user, remembered:) { where(user_ruby_methods: { user_id: user, remembered: }) }

  scope :user_method_count, ->(user, remembered:) { includes([:user_ruby_methods]).where(user_ruby_methods: { user_id: user, remembered: }).count }

  def self.unchallenged_ruby_method(all_methods, challenged_methods)
    all_methods.reject { |method| challenged_methods.include? method }.sample
  end

  def self.ransackable_attributes(auth_object = nil)
    ['name'] # 使ってないが、消すとransackがエラーを発生するので空配列を定義
  end

  def self.ransackable_associations(auth_object = nil)
    ['ruby_module']
  end

  def register_method_url(ruby_method, module_name, ruby_method_name)
    if Net::HTTP.get_response(URI.parse("https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{ruby_method_name}.html")).code == '200'
      ruby_method.official_url = "https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{ruby_method_name}.html"
    else
      ruby_method.official_url = "https://docs.ruby-lang.org/ja/latest/class/#{module_name}.html#I_#{ruby_method_name.upcase.slice(/[^?]+/)}--3F"
    end
  end
end

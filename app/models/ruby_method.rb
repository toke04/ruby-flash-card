# frozen_string_literal: true

class RubyMethod < ApplicationRecord
  has_many :user_ruby_methods, dependent: :destroy
  belongs_to :ruby_module

  validates :name, presence: true, uniqueness: { scope: :ruby_module_id }
  validates :official_url, presence: true

  def register_method_url
    module_name = ruby_module.name
    self.official_url = if Net::HTTP.get_response(URI.parse("https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{name}.html")).code == '200'
                          "https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{name}.html"
                        else
                          "https://docs.ruby-lang.org/ja/latest/class/#{module_name}.html#I_#{name.upcase.slice(/[^?]+/)}--3F"
                        end
  end

  def self.ransackable_attributes(auth_object = nil)
    ['name']
  end

  def self.ransackable_associations(auth_object = nil)
    ['ruby_module']
  end
end

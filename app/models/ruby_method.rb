class RubyMethod < ApplicationRecord
  belongs_to :ruby_module

  validates :name, presence: true, uniqueness: true
  validates :official_url, presence: true
end

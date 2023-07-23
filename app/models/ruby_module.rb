class RubyModule < ApplicationRecord
  has_many :ruby_methods, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end

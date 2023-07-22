class RubyModule < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end

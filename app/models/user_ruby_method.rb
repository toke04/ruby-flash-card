class UserRubyMethod < ApplicationRecord
  belongs_to :user
  belongs_to :ruby_method

  validates :user_id, presence: true, uniqueness: { scope: :ruby_method_id }

  def self.ransackable_attributes(auth_object = nil)
    ['remembered']
  end

  def self.ransackable_associations(auth_object = nil)
    ['ruby_method']
  end
end

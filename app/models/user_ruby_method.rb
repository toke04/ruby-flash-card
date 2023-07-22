class UserRubyMethod < ApplicationRecord
  belongs_to :user
  belongs_to :ruby_method

  validates :user_id, presence: true, uniqueness: { scope: :ruby_method_id }
end

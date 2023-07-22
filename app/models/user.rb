class User < ApplicationRecord
  has_many :user_ruby_methods, dependent: :destroy

  validates :uid, presence: true, uniqueness: { scope: :provider }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
end

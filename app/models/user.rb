# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_ruby_methods, dependent: :destroy
  has_many :challenged_ruby_methods, through: :user_ruby_methods, source: :ruby_method

  with_options presence: true do
    validates :name
    validates :image
  end
  validates :uid, presence: true, uniqueness: { scope: :provider }


  devise :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: [:github]

  def self.find_for_github_oauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create! do |user|
      user.name = auth[:info][:name]
      user.image = auth[:info][:image]
    end
  end
end

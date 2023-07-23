class User < ApplicationRecord
  has_many :user_ruby_methods, dependent: :destroy

  validates :uid, presence: true, uniqueness: { scope: :provider }

  devise :omniauthable, omniauth_providers: [:github]

  def self.find_for_github_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end

end

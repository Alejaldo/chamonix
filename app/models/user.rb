class User < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[ facebook vkontakte ]

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: VALID_EMAIL }

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.find_for_provider_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first

    return user if user.present?

    name = access_token.info.name

    provider = access_token.provider
    id = access_token.extra.raw_info.id

    case provider
    when 'facebook'
      url = "https://facebook.com/#{id}"
      provider_avatar = access_token.info.image.gsub('http', 'https')
    when 'vkontakte'
      url = "https://vk.com/#{id}"
      provider_avatar = access_token.extra.raw_info.photo_400_orig
    end

    where(url: url, provider: provider).first_or_create! do |user|
      user.email = email
      user.name = name
      user.remote_avatar_url = provider_avatar
      user.password = Devise.friendly_token.first(16)
    end
  end
  
  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end

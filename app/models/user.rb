class User < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  before_validation :set_name, on: :create

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: VALID_EMAIL }

  after_commit :link_subscriptions, on: :create

  private

  def set_name
    self.name = "#{I18n.t('activerecord.models.user')} №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end

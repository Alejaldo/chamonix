class Subscription < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  belongs_to :event
  belongs_to :user, optional: true

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: VALID_EMAIL }, unless: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validate :registrated_user_email, unless: -> { user.present? }

  def user_name
    if user.present?
     user.name
    else
     super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def registrated_user_email
    if User.exists?(email: user_email)
      errors.add(:email, I18n.t('titles.registrated_user_email'))
    end
  end
end

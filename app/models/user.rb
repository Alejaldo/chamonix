class User < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :events

  before_validation :set_name, on: :create

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {maximum: 35}
  validates :email, presence: true, length: {maximum: 255}, uniqueness: true, format: { with: VALID_EMAIL }

  private

  def set_name
    self.name = "Пользователь №#{rand(777)}" if self.name.blank?
  end
end

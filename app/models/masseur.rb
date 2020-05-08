class Masseur < ApplicationRecord
  belongs_to :store
  has_many :review, dependent: :delete_all
  has_many :favorite, dependent: :delete_all
  has_many :business_trip_range, dependent: :delete_all
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :masseur_name, presence: true,length: { in: 1..30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 100 }
  validates :adress, length: { in: 5..60 }, allow_blank: true
  validates :phone_number, length: { minimum: 10 }, allow_blank: true
end

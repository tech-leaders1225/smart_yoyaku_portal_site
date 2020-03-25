class Masseur < ApplicationRecord
  belongs_to :store
  has_many :review
  has_many :favorite
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

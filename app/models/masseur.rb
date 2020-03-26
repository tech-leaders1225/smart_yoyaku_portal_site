class Masseur < ApplicationRecord
  belongs_to :store
  has_many :review, dependent: :delete_all
  has_many :favorite, dependent: :delete_all
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

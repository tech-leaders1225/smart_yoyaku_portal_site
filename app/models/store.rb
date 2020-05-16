class Store < ApplicationRecord
  belongs_to :store_manager
  has_many :masseur, dependent: :destroy
  has_many :plan, dependent: :destroy
  has_many :storeimages, dependent: :destroy
  accepts_nested_attributes_for :masseur
  accepts_nested_attributes_for :storeimages
  validates :store_name, presence: true
  validates :adress, length: { minimum: 5 }, allow_blank: true
  validates :store_phonenumber, length: { minimum: 10 }, allow_blank: true
  validates :store_description, length: { minimum: 10 }, allow_blank: true
end

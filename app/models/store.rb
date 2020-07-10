class Store < ApplicationRecord
  belongs_to :store_manager
  has_many :masseurs, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :store_images, dependent: :destroy
  accepts_nested_attributes_for :masseurs
  accepts_nested_attributes_for :store_images
  accepts_nested_attributes_for :plans
  validates :store_name, presence: true
  validates :adress, length: { minimum: 5 }, allow_blank: true
  validates :store_phonenumber, length: { minimum: 10 }, allow_blank: true
  validates :store_description, length: { minimum: 10 }, allow_blank: true
end

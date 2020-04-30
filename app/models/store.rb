class Store < ApplicationRecord
  belongs_to :store_manager
  has_many :masseur, dependent: :destroy
  has_many :plan, dependent: :destroy
end

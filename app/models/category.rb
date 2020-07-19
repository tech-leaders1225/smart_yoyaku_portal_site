class Category < ApplicationRecord
  has_many :masseur_categories, dependent: :delete_all
  has_many :masseurs, through: :masseur_categories
  belongs_to :country
end

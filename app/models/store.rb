class Store < ApplicationRecord
  has_many :masseur, dependent: :destroy
end

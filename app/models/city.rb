class City < ApplicationRecord
  belongs_to :prefecture
  has_many :masseurs, through: :business_trip_ranges
  has_many :business_trip_ranges
end

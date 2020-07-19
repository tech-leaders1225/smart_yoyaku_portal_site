class AddCityNameToBusinessTripRanges < ActiveRecord::Migration[6.0]
  def change
    add_column :business_trip_ranges, :city_name, :string
  end
end

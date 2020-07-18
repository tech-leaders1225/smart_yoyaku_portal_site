class AddCityJudgeToBusinessTripRanges < ActiveRecord::Migration[6.0]
  def change
    add_column :business_trip_ranges, :city_judge, :boolean, default: false
  end
end

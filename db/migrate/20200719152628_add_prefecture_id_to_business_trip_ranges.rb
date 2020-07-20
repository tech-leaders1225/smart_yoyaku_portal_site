class AddPrefectureIdToBusinessTripRanges < ActiveRecord::Migration[6.0]
  def change
    add_column :business_trip_ranges, :prefecture_id, :integer
  end
end

class CreateBusinessTripRanges < ActiveRecord::Migration[6.0]
  def change
    create_table :business_trip_ranges do |t|
      t.string :masseur_business_trip_range
      t.references :masseur

      t.timestamps
    end
  end
end

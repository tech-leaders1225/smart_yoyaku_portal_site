class CreateBusinessTripRanges < ActiveRecord::Migration[6.0]
  def change
    create_table :business_trip_ranges do |t|
      t.references :masseur, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end

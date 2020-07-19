class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name

      t.timestamps
    end
    add_column :categories, :country_id, :integer
  end
end

class CreateStoreimages < ActiveRecord::Migration[6.0]
  def change
    create_table :storeimages do |t|
      t.string :image
      t.references :store,          foreign_key: true
      t.timestamps
    end
  end
end

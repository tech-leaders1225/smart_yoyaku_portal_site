class CreateStoreImages < ActiveRecord::Migration[6.0]
  def change
    create_table :store_images do |t|
      t.json :store_image
      t.references :store,          foreign_key: true
      t.timestamps
    end
  end
end

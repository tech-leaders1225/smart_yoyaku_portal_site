class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :category_name, null: false

      t.timestamps
    end

    create_table :masseur_categories do |t|
      t.belongs_to :masseur
      t.belongs_to :category
      
      t.timestamps
    end
  end
end

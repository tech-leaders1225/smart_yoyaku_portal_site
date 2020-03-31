class CreateMasseurCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :masseur_categories do |t|
      t.references :masseur,  foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end

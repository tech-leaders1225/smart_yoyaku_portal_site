class CreatePlanImages < ActiveRecord::Migration[6.0]
  def change
    create_table :plan_images do |t|
      t.string :image
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end

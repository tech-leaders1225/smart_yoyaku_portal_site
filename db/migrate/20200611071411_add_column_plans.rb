class AddColumnPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :course_id, :bigint
  end
end

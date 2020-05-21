class AddPlanmodelToPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :plan_content, :string
    add_column :plans, :plan_time, :integer
  end
end

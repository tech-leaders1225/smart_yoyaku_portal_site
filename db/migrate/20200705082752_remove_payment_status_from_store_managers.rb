class RemovePaymentStatusFromStoreManagers < ActiveRecord::Migration[6.0]
  def change
    remove_column :store_managers, :payment_status, :boolean
    add_column :store_managers, :order_plan, :integer
  end
end

class AddCalendarStatusToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :calendar_status, :integer, default: 0
  end
end

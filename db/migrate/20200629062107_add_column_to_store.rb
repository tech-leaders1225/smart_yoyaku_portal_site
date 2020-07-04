class AddColumnToStore < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :calendar_secret_id, :bigint
  end
end

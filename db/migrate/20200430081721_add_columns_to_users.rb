class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address, :string, comment: "住所"
    add_column :users, :gender, :integer, comment: "性別"
  end
end

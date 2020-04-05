class RenameMasseurEmailColumnToMasseurs < ActiveRecord::Migration[6.0]
  def change
    rename_column :masseurs, :masseur_email, :email
  end
end

# frozen_string_literal: true

class DeviseCreateMasseurs < ActiveRecord::Migration[6.0]
  def change
    create_table :masseurs do |t|
      ## Database authenticatable
      t.string :masseur_name,       null: false
      t.string :masseur_email,      null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :adress
      t.string :phone_number
      t.references :store,          foreign_key: true
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :masseurs, :masseur_email,        unique: true
    add_index :masseurs, :reset_password_token, unique: true
    # add_index :masseurs, :confirmation_token,   unique: true
    # add_index :masseurs, :unlock_token,         unique: true
  end
end

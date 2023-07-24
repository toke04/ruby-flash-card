# frozen_string_literal: true

class AddColumnPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :encrypted_password, :string, default: '', null: false
  end
end

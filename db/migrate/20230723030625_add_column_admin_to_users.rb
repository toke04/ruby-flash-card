# frozen_string_literal: true

class AddColumnAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
  end
end

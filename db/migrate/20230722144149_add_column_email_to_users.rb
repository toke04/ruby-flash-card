class AddColumnEmailToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string, default: '', null: false
  end
end

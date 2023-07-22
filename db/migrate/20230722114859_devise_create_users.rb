# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid,              null: false
      t.string :provider,         null: false
      t.string :name
      t.string :image

      t.timestamps null: false
    end
  end
end

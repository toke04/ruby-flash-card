# frozen_string_literal: true

class CreateUserRubyMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :user_ruby_methods do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ruby_method, null: false, foreign_key: true
      t.text :memo
      t.boolean :remembered, null: false

      t.timestamps
    end
  end
end

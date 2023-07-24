# frozen_string_literal: true

class AddUniqueRubyMethodName < ActiveRecord::Migration[7.0]
  def change
    add_index :ruby_methods, :name, unique: true
  end
end

# frozen_string_literal: true

class RemoveIndexUserRubyMethodsForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_index :user_ruby_methods, column: :ruby_method_id
    remove_index :user_ruby_methods, column: :user_id
  end
end

# frozen_string_literal: true

class AddUniqueUserRubyMethodsForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_index :user_ruby_methods, %i[user_id ruby_method_id], unique: true
  end
end

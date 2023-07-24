# frozen_string_literal: true

class AddUserRubyMethodsToRememberedWithDefaultFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_default :user_ruby_methods, :remembered, from: nil, to: false
  end
end

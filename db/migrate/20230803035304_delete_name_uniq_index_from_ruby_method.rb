# frozen_string_literal: true

class DeleteNameUniqIndexFromRubyMethod < ActiveRecord::Migration[7.0]
  def change
    remove_index :ruby_methods, column: :name
  end
end

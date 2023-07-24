# frozen_string_literal: true

class CreateRubyMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :ruby_methods do |t|
      t.references :ruby_module, null: false, foreign_key: true
      t.string :name, null: false
      t.string :official_url, null: false, default: 'https://docs.ruby-lang.org/ja/latest/library/_builtin.html'

      t.timestamps
    end
  end
end

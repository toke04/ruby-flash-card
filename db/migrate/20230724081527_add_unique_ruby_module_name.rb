class AddUniqueRubyModuleName < ActiveRecord::Migration[7.0]
  def change
    add_index :ruby_modules, :name, unique: true
  end
end

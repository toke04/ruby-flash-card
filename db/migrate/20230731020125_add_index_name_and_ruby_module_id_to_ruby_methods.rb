class AddIndexNameAndRubyModuleIdToRubyMethods < ActiveRecord::Migration[7.0]
  def change
    add_index :ruby_methods, [:name, :ruby_module_id], unique: true
  end
end

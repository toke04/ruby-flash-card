class AddUniqueUserRubyMethodsForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_index :user_ruby_methods, [:user_id, :ruby_method_id ], unique: true
  end
end

class DeleteNameUniqIndexFromRubyMethod < ActiveRecord::Migration[7.0]
  def change
    remove_index :ruby_methods, :name
  end
end

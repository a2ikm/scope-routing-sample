class AddUserIdToTodos < ActiveRecord::Migration
  def self.up
    add_column :todos, :user_id, :integer, :null => false, :default => 0
    add_index :todos, :user_id
  end

  def self.down
    remove_column :todos, :users
  end
end

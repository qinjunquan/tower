class AddStatusToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :status, :integer, :default => 0
  end
end

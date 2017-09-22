class AddDeletedAtToTodoLists < ActiveRecord::Migration
  def change
    add_column :todo_lists, :deleted_at, :datetime
    add_index :todo_lists, :deleted_at
  end
end

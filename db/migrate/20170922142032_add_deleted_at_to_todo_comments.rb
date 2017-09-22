class AddDeletedAtToTodoComments < ActiveRecord::Migration
  def change
    add_column :todo_comments, :deleted_at, :datetime
    add_index :todo_comments, :deleted_at
  end
end

class CreateTodoComments < ActiveRecord::Migration
  def change
    create_table :todo_comments do |t|
      t.integer :todo_id
      t.integer :creator_id
      t.text :content
      t.text :notice_user_ids
      t.integer :reply_user_id
      t.integer :like_count, :default => 0

      t.timestamps
    end
  end
end

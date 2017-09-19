class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :title
      t.integer :project_id
      t.integer :todo_list_id
      t.text :brief
      t.integer :creator_id
      t.integer :assign_user_id
      t.datetime :expire_date

      t.timestamps
    end
  end
end

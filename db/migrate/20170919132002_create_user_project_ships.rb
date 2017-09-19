class CreateUserProjectShips < ActiveRecord::Migration
  def change
    create_table :user_project_ships do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :access, :default => 0

      t.timestamps
    end
  end
end

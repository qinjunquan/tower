class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :kind
      t.integer :resource_id
      t.string :resource_type
      t.string :resource_title
      t.text :resource_content
      t.integer :project_id
      t.integer :team_id

      t.timestamps
    end
  end
end

class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :team_id
      t.text :brief
      t.integer :creator_id

      t.timestamps
    end
  end
end

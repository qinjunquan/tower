class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :creator_id
      t.string :avator

      t.timestamps
    end
  end
end

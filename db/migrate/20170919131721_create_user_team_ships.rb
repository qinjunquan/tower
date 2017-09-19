class CreateUserTeamShips < ActiveRecord::Migration
  def change
    create_table :user_team_ships do |t|
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end

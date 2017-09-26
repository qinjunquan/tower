class RemoveTeamIdToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :team_id
  end
end

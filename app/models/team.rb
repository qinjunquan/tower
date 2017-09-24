class Team < ActiveRecord::Base
  has_many :user_team_ships
  validates_presence_of :creator_id, :creator_id
end

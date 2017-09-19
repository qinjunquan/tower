class Team < ActiveRecord::Base
  has_many :user_team_ships
end

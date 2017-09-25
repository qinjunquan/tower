class Team < ActiveRecord::Base
  has_many :user_team_ships
  has_many :users, :through => :user_team_ships
  belongs_to :creator, :class_name => User, :foreign_key => :creator_id
  validates_presence_of :creator_id, :creator_id
end

class Project < ActiveRecord::Base
  has_many :user_project_ships
  has_many :users, :through => :user_project_ships
  belongs_to :team
  belongs_to :creator, :class_name => User, :foreign_key => :creator_id
  validates_presence_of :name, :creator_id, :team_id
end

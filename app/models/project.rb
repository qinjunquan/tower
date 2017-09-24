class Project < ActiveRecord::Base
  belongs_to :team
  has_many :user_project_ships
  validates_presence_of :name, :creator_id, :team_id
end

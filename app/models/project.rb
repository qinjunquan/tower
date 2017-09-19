class Project < ActiveRecord::Base
  belongs_to :team
  has_many :user_project_ships
end

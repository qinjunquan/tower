class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_team_ships
  has_many :user_project_ships
  has_many :teams, :through => :user_team_ships
  has_many :projects, :through => :user_project_ships
end

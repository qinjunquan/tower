class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_team_ships
  has_many :user_project_ships
  has_many :teams, :through => :user_team_ships
  has_many :projects, :through => :user_project_ships
  validates_presence_of :email, :name
  validates_uniqueness_of :email, :name


  def project_ids
    self.user_project_ships.map(&:project_id)
  end

  def team_ids
    self.user_team_ships.map(&:team_id)
  end

  class << self
    def current
      Thread.current[:user]
    end

    def current=(user)
      Thread.current[:user] = user
    end
  end
end

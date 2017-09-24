class UserProjectShip < ActiveRecord::Base
  ACCESS = [ "管理员" => 0, "成员" => 1, "访客" => 2 ]
  belongs_to :user
  belongs_to :project
  validates_presence_of :user_id, :project_id
end

class Todo < ActiveRecord::Base
  STATUS = [ "待办" => 0, "执行中" => 1, "完成" => 2 ]

  belongs_to :todo_list
  belongs_to :project
  belongs_to :assign_user, :class_name => User, :foreign_key => :assign_user_id

  scope :publish, lambda { where("deleted_at is null") }

  after_save :create_event

  def create_event
    Event.create_event(self)
  end
end

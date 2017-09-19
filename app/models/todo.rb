class Todo < ActiveRecord::Base
  STATUS = [ "待办" => 0, "执行中" => 1, "完成" => 2, "删除" => 3 ]
  belongs_to :todo_list
  belongs_to :assign_user, :class_name => User, :foreign_key => :assign_user_id
end

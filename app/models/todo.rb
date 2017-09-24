class Todo < ActiveRecord::Base
  STATUS = { "待办" => 0, "执行中" => 1, "完成" => 2 }

  belongs_to :todo_list
  belongs_to :project
  has_many :todo_comments
  belongs_to :assign_user, :class_name => User, :foreign_key => :assign_user_id

  scope :publish, lambda { where("deleted_at is null") }

  after_save :create_event

  def create_event
    Event.create_event(self)
  end

  class << self
    def formated_changes(attr, values)
      case attr
      when "status"
        if values[1] == STATUS["待办"]
          values[0] == STATUS["执行中"] ? "暂停处理这条任务" : "重新打开了任务"
        elsif values[1] == STATUS["执行中"]
          "开始处理这条任务"
        elsif values[1] == STATUS["完成"]
          "完成了任务"
        end
      when "expire_date"
        "将任务完成时间从 #{Event.formated_date(values[0], "没有截止日期")} 修改为 #{Event.formated_date(values[1], "没有截止日期")}"
      when "assign_user_id"
        if values[0].present? && values[1].present?
          "把 #{User.find_by_id(values[0]).try(:name)} 的任务指派给 #{User.find_by_id(values[1]).try(:name)}"
        elsif values[0].present?
          "取消了 #{User.find_by_id(values[0]).try(:name)} 的任务"
        else
          "给 #{User.find_by_id(values[1]).try(:name)} 指派了任务"
        end
      end
    end

  end
end

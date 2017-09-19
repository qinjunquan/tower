class Event < ActiveRecord::Base
  LOAD_COUNT = 50
  default_scope { order("id DESC") }
  KIND = [
    "创建任务" => 0,
    "删除任务" => 1,
    "完成任务" => 2,
    "给任务指派完成者" => 3,
    "修改任务完成者" => 4,
    "修改任务完成时间" => 5,
    "评论任务" => 6,
  ]

  class << self
    def query(options = {})
      scoped = Event.all
      scoped = scoped.where(:team_id => options[:team_id].to_i) if options[:team_id].present?
      scoped = scoped.where(:project_id => options[:project_id].to_i) if options[:project_id].present?
      scoped = scoped.page(options[:page].to_i).per(LOAD_COUNT)
      scoped
    end
  end
end

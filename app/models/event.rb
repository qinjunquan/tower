class Event < ActiveRecord::Base
  LOAD_COUNT = 50
  ACTION = { "create" => 0, "update" => 1, "delete" => 2, "revert" => 3 }
  ACTION_NAME = { "创建了" => 0, "修改了" => 1, "删除了" => 2, "恢复了" => 3 }
  WEEK = ["日", "一", "二", "三", "四", "五", "六"]
  EVENT_ATTRIBUTES = {
    "Todo" => [:status, :expire_date, :assign_user_id]
  }

  serialize :resource_changes, Hash

  belongs_to :user
  belongs_to :project
  belongs_to :category, :polymorphic => true
  belongs_to :resource, :polymorphic => true
  belongs_to :sub_resource, :polymorphic => true

  default_scope { order("id DESC") }

  before_create :set_relate_attributes

  def category_mark
    "#{self.category_type}-#{self.category_id}"
  end

  def category_link
    %Q{<a target="_blank" href="/#{self.category_type.underscore.pluralize}/#{self.category_id}">#{self.category_name}</a>}.html_safe
  end

  def resource_link
    %Q{<a target="_blank" href="/#{self.resource_type.underscore.pluralize}/#{self.resource_id}">#{self.resource_name}</a>}.html_safe
  end

  def sub_resource_link
    if sub_resource_id.present?
      %Q{<a target="_blank" href="/#{self.sub_resource_type.underscore.pluralize}/#{self.sub_resource_id}">#{self.sub_resource_name}</a>}.html_safe
    end
  end

  def category_name
    self.category.try(:name) || self.category.try(:title)
  end

  def resource_name
    self.resource.try(:name) || self.resource.try(:title)
  end

  def sub_resource_name
    self.sub_resource.try(:content) || self.sub_resource.try(:name) || self.sub_resource.try(:title)
  end

  def action_name
    if self.resource_changes.present?
      formated_resource_changes
    else
      ACTION_NAME.key(self.action) + I18n.t("activerecord.models.#{self.sub_resource_type.try(:underscore) || self.resource_type.underscore}.")
    end
  end

  private
  def set_relate_attributes
    case self.resource_type
    when "Todo", "TodoComment", "TodoList"
      if self.resource_type == "TodoComment"
        self.sub_resource_id = self.resource_id
        self.sub_resource_type = self.resource_type
        self.resource_id = self.sub_resource.todo_id
        self.resource_type = "Todo"
      end
      self.project_id = self.resource.project_id
      self.category_type = "Project"
      self.category_id = self.project_id
      self.team_id = self.project.team_id
    end
  end

  def formated_resource_changes
    attr = self.resource_changes.keys.first
    values = self.resource_changes.values.first
    self.resource.class.formated_changes(attr, values)
  end

  class << self
    def query(options = {})
      scoped = Event.includes(:user, :category, :resource, :sub_resource).all
      scoped = scoped.where(:team_id => options[:team_id].to_i) if options[:team_id].present?
      scoped = scoped.where(:project_id => options[:project_id].to_i) if options[:project_id].present?
      scoped = scoped.page(options[:page].to_i).per(LOAD_COUNT)
      scoped
    end

    def create_event(obj)
      event_attr = {}
      if obj.id_was.nil?
        event_attr[:action] = ACTION["create"]
      elsif obj.deleted_at.present? && obj.deleted_at_changed?
        event_attr[:action] = ACTION["delete"]
      elsif obj.deleted_at_changed? && obj.deleted_at.blank?
        event_attr[:action] = ACTION["revert"]
      else
        event_attr[:action] = ACTION["update"]
        if EVENT_ATTRIBUTES[obj.class.to_s].present?
          event_attr[:resource_changes] = obj.changes.select { |k, v| EVENT_ATTRIBUTES[obj.class.to_s].include?(k.to_sym) }
        end
        return true if event_attr[:resource_changes].blank?
      end
      event_attr[:user_id] = User.current.id
      event_attr[:resource_id] = obj.id
      event_attr[:resource_type] = obj.class.to_s
      Event.create(event_attr)
    end

    def formated_date(date, nil_value="没有时间")
      if date.nil?
        nil_value
      elsif date.today?
        "今天"
      elsif date.tomorrow.today?
        "昨天"
      elsif date.yesterday.today?
        "明天"
      elsif date >= Date.today.beginning_of_week && date <= Date.today.end_of_week
        "本周#{WEEK[date.wday]}"
      elsif date >= Date.today.next_week.beginning_of_week && date <= Date.today.next_week.end_of_week
        "下周#{WEEK[date.wday]}"
      else
        date.strftime("%Y-%m-%d")
      end
    end
  end
end

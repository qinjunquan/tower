class Event < ActiveRecord::Base
  LOAD_COUNT = 50
  ACTION = { "create" => 0, "update" => 1, "delete" => 2 }
  EVENT_ATTRIBUTES = {
    "Todo" => [:status, :title, :expire_date, :assign_user_id, :deleted_at]
  }

  belongs_to :project
  belongs_to :category, :polymorphic => true
  belongs_to :resource, :polymorphic => true
  belongs_to :sub_resource, :polymorphic => true

  default_scope { order("id DESC") }

  before_create :set_relate_attributes

  def set_relate_attributes
    case self.resource_type
    when "Todo"
      self.project_id = self.resource.project_id
      self.category_type = "Project"
      self.category_id = self.project_id
      self.team_id = self.project.team_id
    end
  end

  class << self
    def query(options = {})
      scoped = Event.all
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
      else
        event_attr[:action] = ACTION["update"]
        event_attr[:resource_changes] = obj.changes.select { |k, v| EVENT_ATTRIBUTES[obj.class.to_s].include?(k.to_sym) }
        return true if event_attr[:resource_changes].blank?
      end
      event_attr[:user_id] = User.current.id
      event_attr[:resource_id] = obj.id
      event_attr[:resource_type] = obj.class.to_s
      Event.create(event_attr)
    end
  end
end

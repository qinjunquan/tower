class TodoComment < ActiveRecord::Base
  belongs_to :todo
  belongs_to :creator, :class_name => User, :foreign_key => :creator_id
  scope :publish, lambda { where("deleted_at is null") }

  after_save :create_event

  validates_presence_of :todo_id, :content, :creator_id

  def create_event
    Event.create_event(self)
  end
end

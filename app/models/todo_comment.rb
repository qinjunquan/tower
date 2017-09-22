class TodoComment < ActiveRecord::Base
  belongs_to :todo
  belongs_to :creator, :class_name => User, :foreign_key => :creator_id
  scope :publish, lambda { where("deleted_at is null") }

  after_save :create_event

  def create_event
    Event.create_event(self)
  end
end

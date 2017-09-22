class TodoList < ActiveRecord::Base
  has_many :todos

  scope :publish, lambda { where("deleted_at is null") }

  after_save :create_event

  def create_event
    Event.create_event(self)
  end
end

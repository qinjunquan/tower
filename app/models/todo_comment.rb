class TodoComment < ActiveRecord::Base
  belongs_to :todo
  belongs_to :creator, :class_name => User, :foreign_key => :creator_id
end

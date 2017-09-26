require 'rails_helper'

RSpec.describe Todo, type: :model do
  context "test create_event" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      User.current = @user
      @team = FactoryGirl.create(:team, :creator => @user)
      @project = FactoryGirl.create(:project, :team => @team)
      @list = FactoryGirl.create(:todo_list, :creator => @user, :project => @project)
      @todo = FactoryGirl.create(:todo, :project => @project, :creator => @user, :todo_list => @list)
    end

    it "should be create event after create" do
      events = Event.where(:resource_id => @todo.id, :resource_type => "Todo")
      expect(events.count).to eq(1)
      event = events.first
      expect(event.action).to eq(Event::ACTION["create"])
      expect(event.resource_changes.blank?).to eq(true)
      check_todo_event(event)
    end

    it "should be create event after change related attributes" do
      @todo.status = Todo::STATUS["执行中"]
      @todo.save
      events = Event.where(:resource_id => @todo.id, :resource_type => "Todo")
      expect(events.count).to eq(2)
      event = events.first
      expect(event.action).to eq(Event::ACTION["update"])
      expect(event.resource_changes["status"].present?).to eq(true)
      check_todo_event(event)

      @todo.expire_date = Date.today
      @todo.save
      events = Event.where(:resource_id => @todo.id, :resource_type => "Todo")
      expect(events.count).to eq(3)
      event = events.first
      expect(event.action).to eq(Event::ACTION["update"])
      expect(event.resource_changes["expire_date"].present?).to eq(true)
      check_todo_event(event)

      assign_user = FactoryGirl.create(:user)
      @todo.assign_user_id = assign_user.id
      @todo.save
      events = Event.where(:resource_id => @todo.id, :resource_type => "Todo")
      expect(events.count).to eq(4)
      event = events.first
      expect(event.action).to eq(Event::ACTION["update"])
      expect(event.resource_changes["assign_user_id"].present?).to eq(true)
      check_todo_event(event)

      @todo.title = Faker::Hipster.sentence
      @todo.save
      events = Event.where(:resource_id => @todo.id, :resource_type => "Todo")
      expect(events.count).to eq(4)

      @todo.brief = Faker::Hipster.sentence
      @todo.save
      events = Event.where(:resource_id => @todo.id, :resource_type => "Todo")
      expect(events.count).to eq(4)
    end

    it "should be create event after set deleted_at" do
      @todo.deleted_at = Time.now
      @todo.save
      events = Event.where(:resource_id => @todo.id, :resource_type => "Todo")
      expect(events.count).to eq(2)
      event = events.first
      expect(event.action).to eq(Event::ACTION["delete"])
      expect(event.resource_changes.blank?).to eq(true)
      check_todo_event(event)
    end
  end
  def check_todo_event(event)
    expect(event.user_id).to eq(@user.id)
    expect(event.project_id).to eq(@project.id)
    expect(event.category_type).to eq(@project.class.to_s)
    expect(event.category_id).to eq(@project.id)
    expect(event.sub_resource_type.nil?).to eq(true)
    expect(event.sub_resource_id.nil?).to eq(true)
  end
end


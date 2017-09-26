require 'rails_helper'

RSpec.describe TodoList, type: :model do
  context "test create_event" do

    def check_event(event)
      expect(event.user_id).to eq(@user.id)
      expect(event.project_id).to eq(@project.id)
      expect(event.category_type).to eq(@project.class.to_s)
      expect(event.category_id).to eq(@project.id)
      expect(event.resource_changes.blank?).to eq(true)
      expect(event.sub_resource_id.nil?).to eq(true)
      expect(event.sub_resource_type.nil?).to eq(true)
    end

    before(:each) do
      @user = FactoryGirl.create(:user)
      @team = FactoryGirl.create(:team, :creator => @user)
      @project = FactoryGirl.create(:project, :team => @team)
      User.current = @user
    end

    it "should be create event after create" do
      @list = FactoryGirl.create(:todo_list, :creator => @user, :project => @project)
      events = Event.where(:resource_id => @list.id, :resource_type => "TodoList")
      expect(events.count).to eq(1)
      event = events.first
      expect(event.action).to eq(Event::ACTION["create"])
      check_event(event)

      @list.deleted_at = Time.now
      @list.save
      events = Event.where(:resource_id => @list.id, :resource_type => "TodoList")
      expect(events.count).to eq(2)
      event = events.first
      expect(event.action).to eq(Event::ACTION["delete"])
      check_event(event)
    end
  end
end

require 'rails_helper'

RSpec.describe TodoComment, type: :model do
  context "test create_event" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      User.current = @user
      @team = FactoryGirl.create(:team, :creator => @user)
      @project = FactoryGirl.create(:project, :team => @team)
      @list = FactoryGirl.create(:todo_list, :creator => @user, :project => @project)
      @todo = FactoryGirl.create(:todo, :project => @project, :creator => @user, :todo_list => @list)
      @comment = FactoryGirl.create(:todo_comment, :creator => @user, :todo => @todo)
    end

    it "should be create event after create" do
      events = Event.where(:sub_resource_id => @comment.id, :sub_resource_type => "TodoComment")
      expect(events.count).to eq(1)
      event = events.first
      expect(event.action).to eq(Event::ACTION["create"])
      check_event(event)
    end

    it "should be create event after set deleted_at" do
      @comment.deleted_at = Time.now
      @comment.save
      events = Event.where(:sub_resource_id => @comment.id, :sub_resource_type => "TodoComment")
      expect(events.count).to eq(2)
      event = events.first
      expect(event.action).to eq(Event::ACTION["delete"])
      check_event(event)
    end

    it "should not create event after change other attributes" do
      @comment.content = Faker::Hipster.sentence
      @comment.save
      events = Event.where(:sub_resource_id => @comment.id, :sub_resource_type => "TodoComment")
      expect(events.count).to eq(1)
    end
  end

  def check_event(event)
    expect(event.user_id).to eq(@user.id)
    expect(event.project_id).to eq(@project.id)
    expect(event.category_type).to eq(@project.class.to_s)
    expect(event.category_id).to eq(@project.id)
    expect(event.resource_type).to eq(@todo.class.to_s)
    expect(event.resource_id).to eq(@todo.id)
    expect(event.team_id).to eq(@team.id)
    expect(event.resource_changes.blank?).to eq(true)
  end
end

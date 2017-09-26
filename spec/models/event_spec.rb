require 'rails_helper'

RSpec.describe Event, type: :model do
  context "test class method" do
    it "test formated_date" do
      expect(Event.formated_date(nil)).to eq("没有时间")
      expect(Event.formated_date(nil, Date.today.to_s)).to eq(Date.today.to_s)
      today = Date.today
      expect(Event.formated_date(today)).to eq("今天")
      expect(Event.formated_date(today - 1.day)).to eq("昨天")
      expect(Event.formated_date(today + 1.day)).to eq("明天")
      expect(Event.formated_date(today - 15.days)).to eq((today - 15.days).strftime("%Y-%m-%d"))
      expect(Event.formated_date(today + 15.days)).to eq((today + 15.days).strftime("%Y-%m-%d"))
    end

    it "test query" do
      events = Event.query({})
      expect(events.count).to eq(0)

      user = FactoryGirl.create(:user)
      User.current = user
      events = Event.query({})
      expect(events.count).to eq(0)

      team = FactoryGirl.create(:team, :creator => user)
      project = FactoryGirl.create(:project, :team => team)
      list = FactoryGirl.create(:todo_list, :creator => user, :project => project)
      user.reload
      events = Event.query({})
      expect(events.count).to eq(1)

      project = FactoryGirl.create(:project, :team => team)
      list = FactoryGirl.create(:todo_list, :creator => user, :project => project)
      user.reload
      expect(Event.query({}).count).to eq(2)
      expect(Event.query({ :project_id => project.id} ).count).to eq(1)
    end
  end
end

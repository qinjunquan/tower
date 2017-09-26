require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  context "test index action" do
    context "test get index when user not sign in" do
      it "should be redirect_to sign_in" do
        get :index, :team_id => rand(9999)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "test get index when user sign in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "should be 404 when team don't has this user" do
        get :index, :team_id => rand(9999)
        expect(response.status).to eq(404)
      end

      it "should be render index when team has this user" do
        FactoryGirl.create(:team, :creator => @user)
        get :index, :team_id => @user.teams.first.id
        expect(response).to render_template :index
      end

      it "should be 404 when project don't has this user" do
        team = FactoryGirl.create(:team, :creator => @user)
        get :index, :team_id => team.id, :project_id => rand(9999)
        expect(response.status).to eq(404)
      end

      it "should be render index when project has this user" do
        team = FactoryGirl.create(:team, :creator => @user)
        project = FactoryGirl.create(:project, :team => team, :creator_id => @user.id)
        get :index, :team_id => team.id, :project_id => project.id
        expect(response).to render_template :index
      end
    end
  end

  context "test loadmore action" do
    context "test get index when user not sign in" do
      it "should be redirect_to sign_in" do
        get :loadmore, :team_id => rand(9999)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "test get index when user sign in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "should be 404 when team don't has this user" do
        get :loadmore, :team_id => rand(9999)
        expect(response.status).to eq(404)
      end

      it "should be render index when team has this user" do
        FactoryGirl.create(:team, :creator => @user)
        get :loadmore, :team_id => @user.teams.first.id
        expect(response).to render_template(:partial => 'events/_events')

      end

      it "should be 404 when project don't has this user" do
        team = FactoryGirl.create(:team, :creator => @user)
        get :loadmore, :team_id => team.id, :project_id => rand(9999)
        expect(response.status).to eq(404)
      end

      it "should be render index when project has this user" do
        team = FactoryGirl.create(:team, :creator => @user)
        project = FactoryGirl.create(:project, :team => team, :creator_id => @user.id)
        get :loadmore, :team_id => team.id, :project_id => project.id
        expect(response).to render_template(:partial => 'events/_events')
      end
    end
  end
end


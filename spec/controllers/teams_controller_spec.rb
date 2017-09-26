require 'rails_helper'
require 'pry'

RSpec.describe TeamsController, :type => :controller do
  context "test index action" do
    context "test get index when user not sign in" do
      it "should be redirect_to sign_in" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end

      it "should be redirect_to sign_in when pass a fake team id" do
        get :index, :id => rand(9999)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "test get index when user sign in" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "should be 404 when user don't belongs_to any team" do
        get :index
        expect(response.status).to eq(404)
      end

      it "should be 404 when get index with a fake team id" do
        get :index, :id => rand(9999)
        expect(response.status).to eq(404)
      end

      it "should be render home when user belongs_to one team" do
        FactoryGirl.create(:team, :creator => @user)
        get :index
        expect(response).to render_template :index
      end

      it "should be render home when user has_many teams" do
        FactoryGirl.create(:team, :creator => @user)
        FactoryGirl.create(:team, :creator => @user)
        get :index
        expect(response).to render_template :index
      end

      it "should be render home when user belongs_to one team and pass a fake team id" do
        FactoryGirl.create(:team, :creator => @user)
        get :index, :id => rand(9999) + 100
        expect(response).to render_template :index
      end
    end
  end
end



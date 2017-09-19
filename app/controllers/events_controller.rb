#encoding: utf-8
class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @team = Team.find(params[:id])
    @projects = current_user.projects
    @events = Event.query(params.merge({:team_id => @team.id}))
  end
end

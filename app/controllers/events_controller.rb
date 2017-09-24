#encoding: utf-8
class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @team = Team.find(params[:id])
    @projects = current_user.projects
    @events = Event.query(params.merge({:team_id => @team.id}))
  end

  def loadmore
    @events = Event.query(params)
    last_event = Event.find_by_id(params[:last_event_id].to_i)
    if last_event.present?
      @current_yday = last_event.created_at.yday
      @current_category_mark = last_event.category_mark
    end
    render :partial => "events"
  end
end

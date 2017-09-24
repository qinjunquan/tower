#encoding: utf-8
class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_access, :only => [:index, :loadmore]
  def index
    @team = Team.find(params[:team_id])
    @projects = current_user.projects
    @events = Event.query(params)
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

  private
  def check_user_access
    access_fobid = false
    access_fobid = true if params[:team_id].blank? || !current_user.team_ids.include?(params[:team_id].to_i)
    access_fobid = true if params[:project_id].present? && !current_user.project_ids.include?(params[:project_id].to_i)
    return render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false if access_fobid
  end
end

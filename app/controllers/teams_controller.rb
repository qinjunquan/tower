#encoding: utf-8
class TeamsController < ApplicationController
  before_action :authenticate_user!, :only => [:index]
  def index
    @team = Team.find_by_id(params[:id]) || current_user.teams.first
    @projects = current_user.projects
  end
end



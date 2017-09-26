#encoding: utf-8
class TeamsController < ApplicationController
  before_action :authenticate_user!
  def index
    @team = current_user.teams.find_by_id(params[:id]) || current_user.teams.first
    return render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false if @team.blank?
    @projects = current_user.projects.where(:team_id => @team.id)
  end
end



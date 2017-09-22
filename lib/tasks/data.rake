#encoding: utf-8
require "#{Rails.root}/lib/tasks/data.rb"

namespace :data do
  task :drop_tables => :environment do
    [User, Team, UserTeamShip, Project, UserProjectShip].each do |model|
      model.delete_all
    end
  end

  task :users => :environment do
    parse_table(BaseData.user_data).map do |data|
      User.create!(:email => data[:email], :password => "123123", :name => data[:name])
    end
  end

  task :teams => :environment do
    parse_table(BaseData.team_data).map do |data|
      creator = User.find_by_name(data[:creator])
      team = Team.create!(:name => data[:name], :creator_id => creator.id)
      User.where(:name => data[:members].to_s.split(",").map(&:strip)).each do |user|
        team.user_team_ships.create(:user_id => user.id)
      end
    end
  end

  task :projects => :environment do
    parse_table(BaseData.project_data).map do |data|
      creator = User.find_by_name(data[:creator])
      team = Team.where(:name => data[:team]).first_or_create
      project = Project.create!(:name => data[:name], :team_id => team.id, :creator_id => creator.id)
      User.where(:name => data[:members].to_s.split(",").map(&:strip)).each do |user|
        project.user_project_ships.create(:user_id => user.id)
      end
    end
  end

  task :init => :environment do
    tasks = [
      "data:drop_tables",
      "data:users",
      "data:teams",
      "data:projects"
    ]
    tasks.each { |task| Rake::Task[task].invoke }
  end

  def parse_table table
    rows = table.split("\n").reject { |l| l.blank? }
    header = rows[0].split("|").map { |c| c.gsub(/\[T\]/, "") }.map(&:strip).map(&:to_sym)
    records = rows[1..-1]
    collections = []
    records.each_with_index do |record, index|
      attrs = {}
      record.split("|").map(&:strip).each_with_index do |d, i|
        d = d == "nil" ? "" : d
        attrs[header[i]] = d
      end
      collections << attrs
    end
    collections
  end
end



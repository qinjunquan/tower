#encoding: utf-8
require "#{Rails.root}/lib/tasks/data.rb"

namespace :data do
  task :drop_tables => :environment do
    ["users", "teams", "user_team_ships", "projects", "user_project_ships", "todo_lists", "todo_comments", "todos", "events"].each do |table|
      ActiveRecord::Base.connection.execute("truncate #{table}")
    end
  end

  task :users => :environment do
    parse_table(BaseData.user_data).map do |data|
      User.create!(:email => data[:email], :password => "123123", :name => data[:name], :avator => data[:avator])
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

  task :todo_lists => :environment do
    parse_table(BaseData.todo_list_data).map do |data|
      creator = User.find_by_name(data[:creator])
      User.current = creator
      project = Project.find_by_name(data[:project])
      TodoList.create(:name => data[:name], :creator_id => creator.id, :project_id => project.id)
    end
  end

  task :todos => :environment do
    parse_table(BaseData.todo_data).map do |data|
      creator = User.find_by_name(data[:creator])
      User.current = creator
      todo_list = TodoList.find_by_name(data[:todo_list])
      project = Project.find_by_name(data[:project])
      Todo.create(:title => data[:title], :creator_id => creator.id, :project_id => project.id, :todo_list_id => todo_list.id)
    end
  end

  task :todo_changes => :environment do
    parse_table(BaseData.todo_change_data).map do |data|
      creator = User.find_by_name(data[:creator])
      User.current = creator
      todo = Todo.find_by_title(data[:title])
      todo.update_attribute(data[:modify_column].to_sym, data[:column_value])
    end
  end

  task :todo_comments => :environment do
    parse_table(BaseData.todo_comment_data).map do |data|
      creator = User.find_by_name(data[:creator])
      User.current = creator
      todo = Todo.find_by_title(data[:todo])
      comment = TodoComment.create(:content => data[:content], :creator_id => creator.id, :todo_id => todo.id)
      comment.update_attribute(:deleted_at, data[:deleted_at]) if data[:deleted_at].present?
    end
  end

  task :init => :environment do
    tasks = [
      "data:drop_tables",
      "data:users",
      "data:teams",
      "data:projects",
      "data:todo_lists",
      "data:todos",
      "data:todo_changes",
      "data:todo_comments"
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



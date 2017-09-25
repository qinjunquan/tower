FactoryGirl.define do
  factory :project do
    team
    name { Faker::Name.title }
    brief { Faker::Name.title }
    creator_id { team.creator_id }

    after(:create) do |project|
      create(:user_team_ship, :team => project.team, :user => project.creator)
      project.team.users.each do |user|
        create(:user_project_ship, :project => project, :user => user)
      end
    end
  end
end

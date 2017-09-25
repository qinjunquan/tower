FactoryGirl.define do
  factory :project do
    team
    name { Faker::Name.title }
    brief { Faker::Name.title }
    creator_id { team.creator_id }

    after(:create) do |project|
      project.user_project_ships.create(:user_id => project.creator_id)
      project.team.users.each do |user|
        project.user_project_ships.create(:user_id => user.id)
      end
    end
  end
end

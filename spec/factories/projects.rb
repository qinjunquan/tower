FactoryGirl.define do
  factory :project do
    team
    name { Faker::Name.title }
    brief { Faker::Name.title }
    creator_id { team.creator_id }

    after(:create) do |project, evaluator|
      create(:user_project_ship, :project => project, :user => project.creator)
    end
  end
end

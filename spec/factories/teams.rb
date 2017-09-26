FactoryGirl.define do
  factory :team do
#    association creator, factory: user, name: "vik"
    creator
    name { Faker::Team.name }

    after(:create) do |team, evaluator|
      team.user_team_ships.create(:user_id => team.creator.id)
    end

    factory :team_with_users do
      transient do
        users_count 5
      end

      after(:create) do |team, evaluator|
        create_list(:user_team_ship, evaluator.users_count, :team => team)
      end
    end
  end
end


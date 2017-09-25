FactoryGirl.define do
  factory :user, aliases: [:creator] do
    name { Faker::Internet.user_name }
    email { Faker::Internet.email }
    avator { Faker::Avatar.image }
    password { Faker::Internet.password }
  end
end

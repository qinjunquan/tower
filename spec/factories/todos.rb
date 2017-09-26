FactoryGirl.define do
  factory :todo do
    creator
    project
    todo_list
    title { Faker::Hipster.sentence }
    brief { Faker::Hipster.paragraph }
  end
end


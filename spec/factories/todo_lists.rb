FactoryGirl.define do
  factory :todo_list do
    project
    creator
    name { Faker::Name.name }
  end
end

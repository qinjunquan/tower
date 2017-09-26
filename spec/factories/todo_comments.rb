FactoryGirl.define do
  factory :todo_comment do
    todo
    creator
    content { Faker::Hipster.sentence }
  end
end

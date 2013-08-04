# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user_id 1
    text { Faker::Lorem.paragraph }
    score 1
    resource_id 1
  end
end

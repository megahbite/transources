# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user_id 1
    text { Faker::Lorem.paragraph }
    resource_id 1
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { SecureRandom.hex(8) }

    after(:create) do |user, evaluator|
      user.confirm!
    end

    factory :superuser do
      superuser true
    end

    factory :admin do
      after(:create) do |user|
        user.add_role(:admin)
      end
    end
  end
end

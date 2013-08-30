# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
    title { Faker::Lorem.words.join(' ') }
    description { Faker::Lorem.paragraph }
    address_line_1 { Faker::Address.street_address }
    address_line_2 { Faker::Address.secondary_address }
    town { Faker::Address.city }
    country { Faker::Address.country }
    lat (-41.280562)
    long 174.7749028
  end
end

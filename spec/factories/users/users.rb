FactoryBot.define do
  factory :user do
    name  { Faker::Name.first_name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { 0 }
  end
end
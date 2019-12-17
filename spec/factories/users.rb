FactoryBot.define do
  factory :random_user, class: User do
    name {Faker::Name.name_with_middle}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip {Faker::Address.zip_code}
    email {Faker::Internet.email}
    password {Faker::Internet.password}
  end
end

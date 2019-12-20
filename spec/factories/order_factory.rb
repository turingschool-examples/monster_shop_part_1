
FactoryBot.define do
  factory :order, class: Order do
    name {Faker::Name.name}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip {Faker::Address.zip_code}
    user_id {(create :random_user).id}
  end
end

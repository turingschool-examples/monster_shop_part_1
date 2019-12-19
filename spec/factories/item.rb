FactoryBot.define do
  factory :random_item, class: Item do
    name {Faker::FunnyName.name}
    description {Faker::Lorem.sentence}
    price {Faker::Number.between(from: 1, to: 100)}
    sequence(:image) {|n| "http://lorempixel.com/400/300/abstract/#{n}"}
    active? {Faker::Boolean.boolean}
    inventory {Faker::Number.between(from: 1, to: 500)}
  end
end

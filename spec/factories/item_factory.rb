FactoryBot.define do
  factory :item, class: Item do
    association :merchant
    name {Faker::Coffee.blend_name}
    description {Faker::Coffee.notes}
    price {Faker::Commerce.price(range: 2.0..10.0)}
    image {Faker::LoremFlickr.image(search_terms: ['coffee'])}
    inventory {rand(50)}
  end
end

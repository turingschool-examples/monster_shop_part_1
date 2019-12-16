FactoryBot.define do
  factory :random_item, class: Item do
    name {Faker::Coffee.blend_name}
    description {Faker::Coffee.notes}
    price {Faker::Commerce.price(range: 2.0..10.0)}
    image {Faker::LoremFlickr.image(search_terms: ['coffee'])}
    inventory {rand(50)}
    created_at {Faker::Time.between(from: DateTime.now - 50, to: DateTime.now)}
  end
end

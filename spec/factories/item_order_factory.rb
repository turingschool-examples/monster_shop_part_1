
FactoryBot.define do
  factory :item_order, class: ItemOrder do
    association :order
    association :item
    price {Faker::Commerce.price(range: 2.0..10.0)}
    quantity {rand(1..50)}
  end
end

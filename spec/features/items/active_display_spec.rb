require 'rails_helper'

RSpec.describe "As any kind of user" do
  it "can visit item index page and only see active items" do
    dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items"

    expect(page).to have_css("#item-#{pull_toy.id}")
    expect(page).to have_content(pull_toy.name)
    expect(page).not_to have_css("#item-#{dog_bone.id}")
    expect(page).not_to have_content(dog_bone.name)
  end
end

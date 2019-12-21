require 'rails_helper'

RSpec.describe "user logging out" do
  it "redirects to welcome page, empties cart, and displays flash message" do
    user = User.create!(name: "Polly Esther", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "veryoriginalemailgmail.com", password: "polyester", password_confirmation: "polyester")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    visit "/items/#{pull_toy.id}"
    click_on "Add To Cart"

    visit "/items/#{tire.id}"
    click_on "Add To Cart"
    visit "/items/#{tire.id}"
    click_on "Add To Cart"

    visit '/profile'

    within '.topnav' do
      expect(page).to have_content("Cart: 3")
      click_link "Log Out"
    end

    expect(current_path).to eq('/')
    expect(page).to have_content("You have been logged out.")

    within '.topnav' do
      expect(page).to have_content("Cart: 0")
    end
  end
end

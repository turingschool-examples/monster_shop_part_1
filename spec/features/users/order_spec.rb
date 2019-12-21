require 'rails_helper'

RSpec.describe "user logging out" do
  it "redirects to welcome page, empties cart, and displays flash message" do
    user = User.create!(name: "Polly Esther", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "veryoriginalemailgmail.com", password: "polyester", password_confirmation: "polyester")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

    visit "/items/#{pull_toy.id}"
    click_on "Add To Cart"
    visit "/items/#{tire.id}"
    click_on "Add To Cart"
    visit "/items/#{tire.id}"
    click_on "Add To Cart"

    visit "/cart"

    click_on "Checkout"

    name = "Bert"
    address = "123 Sesame St."
    city = "NYC"
    state = "New York"
    zip = 10001

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Create Order"

    # expect(tire.inventory).to eq(10)
    # expect(pull_toy.inventory).to eq(31)

    new_order = Order.last

    expect(page).to have_content('Order status: pending')

    click_on 'Order number:'
    # binding.pry
    expect(page).to have_link('Cancel Order')
    click_on 'Cancel Order'

    expect(current_path).to eq("/profile")

    expect(page).to have_content('Your order has been cancelled')

    expect(Order.last.status).to eq('cancelled')

    expect(Order.last.item_orders[0].status).to have_content('unfulfilled')

    expect(Order.last.item_orders[1].status).to have_content('unfulfilled')

    expect(tire.inventory).to eq(12)
    expect(pull_toy.inventory).to eq(32)

  end
end


# Order.last.item_orders

#     As a registered user
# When I visit an order's show page
# I see a button or link to cancel the order only if the order is still pending
# When I click the cancel button for an order, the following happens:
#
# Each row in the "order items" table is given a status of "unfulfilled"
# The order itself is given a status of "cancelled"
# Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
# I am returned to my profile page
# I see a flash message telling me the order is now cancelled
# And I see that this order now has an updated status of "cancelled"

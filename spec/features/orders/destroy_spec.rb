require 'rails_helper'

RSpec.describe "As a default user" do

  before :each do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    @user = create(:random_user)

    @order = @user.orders.create(name: "Jordan", address: "123 Hi Road", city: "Cleveland", state: "OH", zip: "44333")
    @tire_order = ItemOrder.create!(item: @tire, order: @order, price: @tire.price, quantity: 5)
  end

  describe 'When I am on the order show page' do
    it "has a button to cancel that order if the order is pending" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit "/profile/orders/#{@order.id}"

      expect(page).to have_content("PENDING")

      within "#cancel" do
        expect(page).to have_button("Cancel Order")
      end
    end

    it "the order is given a status of cancelled and I am redirected to my profile page" do

      visit "/login"

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"

      visit "/profile/orders/#{@order.id}"

      click_button "Cancel Order"

      order = Order.find(@order.id)
      expect(order.current_status).to eq("CANCELLED")
      expect(current_path).to eq("/profile")
    end
  end
end





#   As a registered user
# When I visit an order's show page
# I see a button or link to cancel the order only if the order is still pending
# When I click the cancel button for an order, the following happens:
#
# Each row in the "order items" table is given a status of "unfulfilled"
# The order itself is given a status of "cancelled"
# Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
# I am returned to my profile page
# I see a flash message telling me the order is now cancelled
# And I see that this order now has an updated status of “cancelled”

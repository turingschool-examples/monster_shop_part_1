require 'rails_helper'

RSpec.describe 'All merchants fulfill items on an order' do
  before :each do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    @user = create :random_reg_user_test
  end
  it 'and the order status changes from pending to packaged' do
    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'

    click_button 'Log In'

    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
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

    new_order = Order.last

    expect(new_order.status).to eq('Pending')

    new_order.item_orders.each do |item_order|
      expect(item_order.fulfilled_by_merchant).to be false
    end

    new_order.item_orders.first.update(fulfilled_by_merchant: true)
    expect(new_order.status).to eq('Pending')

    new_order.item_orders.each do |item_order|
      item_order.update(fulfilled_by_merchant: true)
    end

    expect(new_order.order_status).to eq('Packaged')
  end
end

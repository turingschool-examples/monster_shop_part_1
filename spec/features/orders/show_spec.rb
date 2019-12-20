require 'rails_helper'

RSpec.describe "as a registered user" do
  before :each do
    @user = create(:random_user)
    visit '/'

    click_link "Login"
    expect(current_path).to eq('/login')

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Login"

  end
  describe "when I visit my order index page" do
    it "the order ID links to the order show page" do
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      order = @user.orders.create(name: "Jordan", address: "123 Hi Road", city: "Cleveland", state: "OH", zip: "44333")
      ItemOrder.create!(item: tire, order: order, price: tire.price, quantity: 5)
      ItemOrder.create!(item: paper, order: order, price: paper.price, quantity: 3)
      ItemOrder.create!(item: pencil, order: order, price: pencil.price, quantity: 9)

      visit "/profile/orders/"

      click_link "#{order.id}"

      expect(current_path).to eq("/profile/orders/#{order.id}")
    end

  end
end

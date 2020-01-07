require 'rails_helper'

RSpec.describe 'Merchant Order Show Page' do
  describe 'as a merchant when I visit an order show page from my dashboard' do
    before :each do
      @admin = create :random_admin_user
      @user = create :random_reg_user_test
      @merchant = create :merchant
      @merchant_user = create :random_merchant_user, merchant:@merchant
      @item = create :item, merchant: @merchant, inventory: 10
      @order = create :order, user: @user
      ItemOrder.create(order_id: @order.id, item_id: @item.id, price: @item.price, quantity: 1)
    end

    it "can display the customer's name and address
        only displays items in the order from my merchant
        no items from other merchants
        name of item which is a link to item show page
        image of item, price and quantity user wishes to purchase" do

      visit '/login'

      fill_in :email, with: @merchant_user.email
      fill_in :password, with: 'password'

      click_button 'Log In'

      within "#merchant_dashboard_orders" do
        click_link @order.id
      end

      expect(current_path).to eq("/merchant/orders/#{@order.id}")

      @order.item_orders.each do |item_order|
        within "#item-#{item_order.item_id}" do
          expect(page).to have_css("img[src*='#{item_order.item.image}']")
          expect(page).to have_link(item_order.item.name)
          expect(page).to have_content("$#{item_order.price}")
          expect(page).to have_content(item_order.quantity)
          expect(page).to have_button('Fulfill')

          expect(@item.inventory).to eq(10)
          click_button 'Fulfill'
          item = Item.last
          expect(item.inventory).to eq(9)

          click_button 'Unfulfill'
          item = Item.last
          expect(item.inventory).to eq(10)
        end
      end

      item_2= create :item, merchant: @merchant, inventory: 5
      order_2 = create :order, user: @user
      item_order_2 = ItemOrder.create(order_id: order_2.id, item_id: item_2.id, price: item_2.price, quantity: 6)

      visit "/merchant/orders/#{order_2.id}"
      within "#item-#{item_order_2.item_id}" do
        expect(page).to have_button('Not Enough Inventory', disabled: true)
      end
    end
  end
end

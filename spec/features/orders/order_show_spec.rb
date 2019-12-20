require 'rails_helper'

RSpec.describe 'as a user when i visit an orders show page', type: :feature do
  before :each do
    @user = create :random_reg_user_test
    @order = create :order, user: @user


  end

  it 'will render the order show page' do
    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'

    click_button 'Log In'

    visit "/profile/orders/#{@order.id}"

    expect(page).to have_content(@order.name)
    expect(page).to have_content(@order.address)
    @order.items.each do |item|
      expect(page).to have_content(item.name)
      expect(page).to have_content(item.merchant)
      expect(page).to have_content(item.price)
    end
  end

  it 'will 404 if not default user' do
    visit "/profile/orders/#{@order.id}"

    expect(page).to have_content('404 Page Not Found')
  end

  it 'will cancel order id i click on the cancel order button' do
    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'

    click_button 'Log In'

    visit "/profile/orders/#{@order.id}"

    click_button 'Cancel Order'

    expect(@order.Cancelled?)
  end
end

require 'rails_helper'

RSpec.describe 'as a merchant' do
  before :each do
    @merchant = create :merchant
    @merchant_user = create :random_merchant_user, merchant: @merchant
    @items = create_list :item, 5, merchant: @merchant

    visit 'login'

    fill_in :email, with: @merchant_user.email
    fill_in :password, with: 'password'

    click_button 'Log In'
  end

  it 'reverts to default image if image field is blank' do
    visit '/merchant/items'

    within "#item-#{@items[0].id}" do
      click_link 'Edit Item'
    end

    expect(current_path).to eq("/items/#{@items[0].id}/edit")

    fill_in :image, with: ''
    click_button 'Update Item'

    visit "/items/#{@items[0].id}"

    expect(page).to have_css("img[src*='https://media3.s-nbcnews.com/j/newscms/2019_33/2203981/171026-better-coffee-boost-se-329p_67dfb6820f7d3898b5486975903c2e51.fit-760w.jpg']")
  end


end

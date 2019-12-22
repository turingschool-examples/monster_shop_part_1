require 'rails_helper'

RSpec.describe 'As a merchant', type: :feature do
  before :each do
    @user = create :random_merchant_user

    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'
    click_button 'Log In'
  end

  it 'is a merchant' do
    expect(@user.merchant?)
  end

  it 'will prevent me from visiting /admin' do
    visit '/admin'
    expect(page).to have_content('404 Page Not Found')

    visit '/admin/dashboard'
    expect(page).to have_content('404 Page Not Found')
  end

end

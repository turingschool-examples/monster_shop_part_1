require 'rails_helper'

RSpec.describe 'As an admin', type: :feature do
  before :each do
    @user = create :random_admin_user

    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'

    click_button 'Log In'
  end

  it 'is an admin' do
    expect(@user.admin?)
  end

  it 'will prevent me from visiting /merchant' do
    visit '/merchant'
    expect(page).to have_content('404 Page Not Found')

    visit '/merchant/dashboard'
    expect(page).to have_content('404 Page Not Found')
  end

  it 'will prevent me from visiting /cart' do
    visit '/cart'
    expect(page).to have_content('404 Page Not Found')
  end
end

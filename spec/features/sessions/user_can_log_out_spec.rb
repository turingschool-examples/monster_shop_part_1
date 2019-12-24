require 'rails_helper'

RSpec.describe 'when the user clicks the logout button', type: :feature do
  before :each do
    User.destroy_all
    @user = User.create(
      name: 'Granicus Higgins',
      email: 'lol@ex.com',
      address: '123 mail',
      city: 'Denver',
      state: 'CO',
      zip: '80123',
      password: 'pass123'
    )

    @admin_user = User.create(
      name: 'Matt',
      email: 'werwer@sefsdfsdfsdfsdfsdf',
      address: '123 poop ln',
      city: 'Denver',
      state: 'CO',
      zip: '80000',
      password: 'pass123',
      role: 1
    )

    @merchant_user = User.create(
      name: 'Matt',
      email: 'wersdfsdfsdfawdqwevdhtjtyhgrfgeer@sefsdfsdfsdfsdfsdf',
      address: '123 poop ln',
      city: 'Denver',
      state: 'CO',
      zip: '80000',
      password: 'pass123',
      role: 2
    )

    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'pass123'

    click_button 'Log In'
  end

  it 'can log out' do

    expect(page).to have_content('Log Out')
    click_on 'Log Out'

    expect(current_path).to eq('/')
    expect(page).to have_content('Goodbye!')
  end

  it 'will clear cart upon logout' do
    item = create :item

    visit "/items/#{item.id}"
    click_button 'Add To Cart'

    expect(page).to have_content('Cart: 1')

    click_on 'Log Out'
    expect(page).to have_content('Cart: 0')
  end
end

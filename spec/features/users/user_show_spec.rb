require 'rails_helper'

RSpec.describe "As a registered user and visit my profile page" do
  before :each do
    @user = User.create(
      name: 'Granicus Higgins',
      email: 'lol@ex.com',
      address: '123 mail',
      city: 'Denver',
      state: 'CO',
      zip: '80123',
      password: 'pass123'
      )

      visit '/login'

      fill_in :email, with: @user.email
      fill_in :password, with: 'pass123'

      click_button 'Log In'
      expect(current_path).to eq('/profile')
  end

  it "shows all of my profile data minus my password and I see a link to edit my profile" do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.email)
    expect(page).to have_content(@user.address)
    expect(page).to have_content(@user.city)
    expect(page).to have_content(@user.state)
    expect(page).to have_content(@user.zip)
    expect(page).to_not have_content(@user.password)

    expect(page).to have_link("Edit Profile")
  end

  it 'has button leading to order index page' do
    click_on 'My Orders'

    expect(current_path).to eq('/profile/orders')
  end
end

require 'rails_helper'

RSpec.describe 'As a visitor' do
  it "can click on register link in the nav bar" do
    visit '/'

    within 'nav' do
      click_link 'Register'
    end

    expect(current_path).to eq('/register')
  end

  it "can register a new user" do
    visit '/register'

    name = 'Billy Bobby'
    address = '123 Maine Street'
    city = 'Denver'
    state = 'CO'
    zip = '80211'
    email = 'billyboy@gmail.com'
    password = 'secret'

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip_code, with: zip
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_button 'Create User'

    flash = "Welcome, #{name}! You're now registered!"

    expect(current_path).to eq('/profile')
    expect(page).to have_content(flash)
  end
end
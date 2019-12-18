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
    expect(page).to have_content("#{name}'s Profile")
  end

  it "returns flash message, if all required fields are not completed" do
    visit "/register"

    name = 'Billy Bobby'
    city = 'Denver'
    state = 'CO'
    zip = '80211'
    email = 'billyboy@gmail.com'
    password = 'secret'

    fill_in :name, with: name
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip_code, with: zip
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_button "Create User"
    expect(page).to have_button("Create User")
    expect(page).to have_content("Address can't be blank")
  end

  it "does not allow duplicate email" do
    user = create(:random_user)

    visit "/register"

    fill_in :name, with: user.name
    fill_in :address, with: user.address
    fill_in :city, with: user.city
    fill_in :state, with: user.state
    fill_in :zip_code, with: user.zip_code
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password

    click_button "Create User"
    expect(page).to have_button("Create User")

    expect(find_field(:name).value).to eq(user.name)
    expect(find_field(:address).value).to eq(user.address)
    expect(find_field(:city).value).to eq(user.city)
    expect(find_field(:state).value).to eq(user.state)
    expect(find_field(:zip_code).value).to eq(user.zip_code)
    expect(page).to have_content("Email has already been taken")
    expect(find_field(:email).value.blank?).to eq(true)
    expect(find_field(:password).value.blank?).to eq(true)
  end
end

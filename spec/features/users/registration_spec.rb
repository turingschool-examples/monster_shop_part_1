require 'rails_helper'

require 'rails_helper'

RSpec.describe 'user registration' do
  it "I can click on a register link on the nav bar and register as a user when I enter the following:
  - my name
  - my street address
  - my city
  - my state
  - my zip code
  - my email address
  - my preferred password
  - a confirmation field for my password" do

    visit '/'

    within '.topnav' do
      click_link "Register"
    end

    expect(current_path).to eq('/register')
    fill_in :name, with: "Liz Anya"
    fill_in :address, with: "7892 Main Street"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80207
    fill_in :email, with: "liz_anya05@gmail.com"
    fill_in :password, with: "password123"
    click_button "Register as a User"

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Welcome, Liz Anya! You are now logged in.")
  end

  it "I receive an error flash message if I try to register with missing fields" do
    visit '/register'

    fill_in :name, with: "Liz Anya"
    fill_in :address, with: "7892 Main Street"
    fill_in :city, with: ""
    fill_in :state, with: "CO"
    fill_in :zip, with: 80207
    fill_in :email, with: ""
    fill_in :password, with: "password123"
    click_button "Register as a User"

    expect(current_path).to eq('/register')
    expect(page).to have_content("City can't be blank and Email can't be blank")
  end
end

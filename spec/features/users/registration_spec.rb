require 'rails_helper'

require 'rails_helper'

RSpec.describe 'user registration' do
  describe 'as a visitor' do
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
      fill_in :password_confirmation, with: "password123"
      click_button "Register as a User"

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Welcome, Liz Anya! You are now logged in.")
    end

    it "I receive an error flash message if I try to register with missing fields" do
      visit '/'

      click_link 'Register'

      fill_in :name, with: "Liz Anya"
      fill_in :address, with: "7892 Main Street"
      fill_in :city, with: ""
      fill_in :state, with: "CO"
      fill_in :zip, with: 80207
      fill_in :email, with: ""
      fill_in :password, with: "password123"
      fill_in :password_confirmation, with: "password123"
      click_button "Register as a User"

      expect(current_path).to eq('/users')
      expect(page).to have_content("City can't be blank and Email can't be blank")
    end

    it "I cannot register without a unique email" do
      user = User.create(name: "Polly Esther", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "veryoriginalemail@gmail.com", password: "polyester", password_confirmation: "polyester")

      visit '/'

      click_link 'Register'

      fill_in :name, with: "Justin Thyme"
      fill_in :address, with: "8923 South Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80201
      fill_in :email, with: "veryoriginalemail@gmail.com"
      fill_in :password, with: "turing"
      fill_in :password_confirmation, with: "turing"
      click_button "Register as a User"

      expect(current_path).to eq('/users')
      expect(page).to have_content('Email has already been taken')

      expect(find_field('Name').value).to eq('Justin Thyme')
      expect(find_field('Address').value).to eq('8923 South Street')
      expect(find_field('City').value).to eq('Denver')
      expect(find_field('State').value).to eq('CO')
      expect(find_field('Zip').value).to eq('80201')
      expect(find_field('Email').value).to eq(nil)
      expect(find_field('Password').value).to eq(nil)
    end
  end
end

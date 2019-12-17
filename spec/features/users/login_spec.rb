require 'rails_helper'

RSpec.describe 'user login' do
  describe 'as a user' do
    it "when I login with valid credentials, I am redirected to my profile page and see flash message that I'm logged in" do
      user = User.create!(name: "Polly Esther", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "veryoriginalemail@gmail.com", password: "polyester", password_confirmation: "polyester")

      visit "/"

      within '.topnav' do
        click_link "Log In"
      end

      expect(current_path).to eq('/login')

      fill_in :email, with: "veryoriginalemail@gmail.com"
      fill_in :password, with: "polyester"
      click_button "Log In"

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Hello, #{user.name}. You are now logged in.")
    end

    it "I cannot login with bad credentials" do
      user = User.create!(name: "Polly Esther", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "veryoriginalemail@gmail.com", password: "polyester", password_confirmation: "polyester")

      visit "/"

      within '.topnav' do
        click_link "Log In"
      end

      expect(current_path).to eq('/login')

      fill_in :email, with: "originalemail@gmail.com"
      fill_in :password, with: "linen"
      click_button "Log In"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Login credentials are incorrect. Please try again.")
    end

    it "after I have logged in, when I visit login page I am redirected to my profile page" do
      user = User.create!(name: "Polly Esther", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "veryoriginalemail@gmail.com", password: "polyester", password_confirmation: "polyester")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      within '.topnav' do
        click_link "Log In"
      end

      expect(current_path).to eq('/profile')
      expect(page).to have_content("You are already logged in.")
    end
  end

  # describe 'as a merchant user' do
  #   it "when I login, I am redirected to my merchant dashboard page and see flash message that I'm logged in" do
  #     merchant = User.create!(name: "Robyn Banks", address: "1832 West Street", city: "Denver", state: "CO", zip: 37293, email: "robynbanks@gmail.com", password: "apples", password_confirmation: "apples", role: 2)
  #
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
  #
  #     within '.topnav' do
  #       click_link "Log In"
  #     end
  #
  #     expect(current_path).to eq('/login')
  #
  #     fill_in :email, with: "robynbanks@gmail.com"
  #     fill_in :password, with: "apples"
  #     click_button "Log In"
  #
  #     expect(current_path).to eq("/merchant/#{merchant.id}/dashboard")
  #     expect(page).to have_content("Hello, #{merchant.name}. You are now logged in.")
  #   end
  # end
  #
  # describe 'as an admin user' do
  #   it "when I login, I am redirected to my admin dashboard page and see flash message that I'm logged in" do
  #     admin = User.create!(name: "Rick O'Shea", address: "1738 West Street", city: "Denver", state: "CO", zip: 92739, email: "rickoshea@gmail.com", password: "bananas", password_confirmation: "bananas", role: 1)
  #
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #     within '.topnav' do
  #       click_link "Log In"
  #     end
  #
  #     expect(current_path).to eq('/login')
  #
  #     fill_in :email, with: "rickoshea@gmail.com"
  #     fill_in :password, with: "bananas"
  #     click_button "Log In"
  #
  #     expect(current_path).to eq("/admin/#{admin.id}/dashboard")
  #     expect(page).to have_content("Hello, #{admin.name}. You are now logged in.")
  #   end
  # end
end

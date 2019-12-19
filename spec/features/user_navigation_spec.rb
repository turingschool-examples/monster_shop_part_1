require 'rails_helper'
# User Story 3, User Navigation

RSpec.describe "As a registered regular user" do
  before :each do
    user = User.create(
      name: "Monica",
      street_address: "123 Five Street",
      city: "Denver",
      state: "CO",
      zip: "80210",
      email: "fake@gmail.com",
      password: "wordpass",
      role: 0
    )
    visit "/login"

    fill_in :email, with: user.email
    fill_in :password, with: "wordpass"

    click_on "Sign In"


  end
  it "I see the same links as a visitor" do
    # add additional testing from visitor test

  end

  it "I see a link to profile page and log out, and a welcome message" do
    within ".topnav" do
      expect(page).to have_link('My Profile Page')
      # add back in once log out functionality is up to date
      # expect(page).to have_link('Log out')

      expect(page).to have_content("Logged in as Monica")
    end
  end
end

# - a link to return to the welcome / home page of the application ("/")
# - a link to browse all items for sale ("/items")
# - a link to see all merchants ("/merchants")
# - a link to my shopping cart ("/cart")
# - a link to log in ("/login")
# - a link to the user registration page ("/register")
#
# Next to the shopping cart link I see a count of the items in my cart

# - a link to my profile page ("/profile")
# - a link to log out ("/logout")

# I also see text that says "Logged in as Mike Dao" (or whatever my name is)

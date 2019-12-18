require 'rails_helper'

RSpec.describe "As an user" do
  it "I go to my user profile page" do
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

    click_on "Login"

    expect(current_path).to eq("/users/profile")
    expect(page).to have_content("Welcome, user. You are the User.")
  end
end

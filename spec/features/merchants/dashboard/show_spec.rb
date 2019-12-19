require 'rails_helper'

RSpec.describe "As an merchant" do
  it "I go to my merchant profile page" do
    merchant = User.create(
      name: "Joey",
      street_address: "123 Five Street",
      city: "Denver",
      state: "CO",
      zip: "80210",
      email: "fake@gmail.com",
      password: "wordpass",
      role: 2
    )

    visit "/login"

    fill_in :email, with: merchant.email
    fill_in :password, with: "wordpass"

    click_on "Sign In"

    expect(current_path).to eq("/merchants/dashboard")
    expect(page).to have_content("Welcome merchant, #{merchant.name}!")
    expect(page).to have_content("Welcome, user. You are the Merchant.")

  end
end

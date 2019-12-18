require 'rails_helper'

RSpec.describe "User profile page" do
  let(:user) {{
    name: "Joey",
    street_address: "123 Five Street",
    city: "Denver",
    state: "CO",
    zip: "80210",
    email: "fake@gmail.com",
    password: "wordpass",
    role: 0
  }}

  context "user logs in and is directed to profile page" do

    before{visit "/login"}

    fill_in :email, with: user[:email]
    fill_in :password, with: user[:password]

    click_on "Login"

    expect(current_path).to eq("/users/profile")
    expect(page).to have_content("Welcome, you are the User.")
  end
end

require 'rails_helper'

RSpec.describe "as a user" do
  it "can login with valid credentials" do
    user = User.create!(name: "Jordan",
                        address: "394 High St",
                        city: "Denver",
                        state: "CO",
                        zip_code: "80602",
                        email: "hotones@hotmail.com",
                        password: "password",
                        password_confirmation: "password")

    visit '/'

    click_link "Login"
    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Login"

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Welcome, #{user.name}, you are logged in!")


    within "nav" do
      expect(page).not_to have_link("Login")
      expect(page).not_to have_link("Register")
      expect(page).to have_link("Log Out")
    end

  end
end

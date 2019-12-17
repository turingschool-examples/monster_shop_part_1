require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(username: "funbucket13", password: "test")

    visit "/"

    click_on "I already have an account"

    expect(current_path).to eq('/login')

    fill_in :name, with: user.name
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq('/')

    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_link("Log out")
    expect(page).to_not have_link("Register as a User")
    expect(page).to_not have_link("I already have an account")
  end
end

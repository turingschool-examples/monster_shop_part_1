require 'rails_helper'

RSpec.describe 'as a merchant', type: :feature do
  it "redirects me to merchant dashboard after login" do
    merchant = User.create(name: "Jordan",
                           address: "394 High St",
                           city: "Denver",
                           state: "CO",
                           zip_code: "80602",
                           email: "hotones@hotmail.com",
                           password: "password",
                           password_confirmation: "password",
                           role: 2)

    visit '/login'

    fill_in :email, with: merchant.email
    fill_in :password, with: merchant.password

    click_button "Login"

    expect(current_path).to eq('/merchant/dashboard')
    expect(page).to have_content("Welcome, #{merchant.name}, you are logged in!")
  end
end
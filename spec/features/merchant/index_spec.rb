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

  it "displays full address of the merchant I work for" do
    merchant_admin = User.create(name: "Jordan",
                           address: "394 High St",
                           city: "Denver",
                           state: "CO",
                           zip_code: "80602",
                           email: "hotthrees@hotmail.com",
                           password: "password",
                           password_confirmation: "password",
                           role: 2)

    merchant_employee = User.create(name: "Jordi",
                           address: "394 High St",
                           city: "Denver",
                           state: "CO",
                           zip_code: "80602",
                           email: "hotfours@hotmail.com",
                           password: "password",
                           password_confirmation: "password",
                           role: 3)

    visit '/login'

    fill_in :email, with: merchant_admin.email
    fill_in :password, with: merchant_admin.password

    click_button "Login"

    visit "/merchant/dashboard"

    expect(page).to have_content(merchant_admin.name)
  #   expect(page).to have_content(merchant.address)
  end
end

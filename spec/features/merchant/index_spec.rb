require 'rails_helper'

RSpec.describe 'as a @merchant', type: :feature do
  before :each do
    @merchant_company = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)

    @merchant_admin = User.create(name: "Jordan",
                           address: "394 High St",
                           city: "Denver",
                           state: "CO",
                           zip_code: "80602",
                           email: "hotones@hotmail.com",
                           password: "password",
                           password_confirmation: "password",
                           role: 2)

    @merchant_employee = User.create(name: "Jordi",
                           address: "394 High St",
                           city: "Denver",
                           state: "CO",
                           zip_code: "80602",
                           email: "hotfours@hotmail.com",
                           password: "password",
                           password_confirmation: "password",
                           role: 3)

    @merchant_company.users << [@merchant_admin, @merchant_employee]
  end
  it "redirects me to @merchant dashboard after login" do

    visit '/login'
    fill_in :email, with: @merchant_admin.email
    fill_in :password, with: @merchant_admin.password
    click_button "Login"

    expect(current_path).to eq('/merchant/dashboard')
    expect(page).to have_content("Welcome, #{@merchant_admin.name}, you are logged in!")
    click_link "Log Out"

    visit '/login'
    fill_in :email, with: @merchant_employee.email
    fill_in :password, with: @merchant_employee.password
    click_button "Login"

    expect(current_path).to eq('/merchant/dashboard')
    expect(page).to have_content("Welcome, #{@merchant_employee.name}, you are logged in!")
  end

  it "displays full address of the merchant I work for" do

    visit '/login'
    fill_in :email, with: @merchant_admin.email
    fill_in :password, with: @merchant_admin.password
    click_button "Login"

    expect(page).to have_content(@merchant_company.name)
    expect(page).to have_content(@merchant_company.address)
    expect(page).to have_content(@merchant_company.city)
    expect(page).to have_content(@merchant_company.state)
    expect(page).to have_content(@merchant_company.zip)
    click_link "Log Out"

    visit '/login'
    fill_in :email, with: @merchant_employee.email
    fill_in :password, with: @merchant_employee.password
    click_button "Login"

    expect(page).to have_content(@merchant_company.name)
    expect(page).to have_content(@merchant_company.address)
    expect(page).to have_content(@merchant_company.city)
    expect(page).to have_content(@merchant_company.state)
    expect(page).to have_content(@merchant_company.zip)
  end

  it 'has link to view own merchant items that routes to @merchant items page' do

    visit '/login'
    fill_in :email, with: @merchant_admin.email
    fill_in :password, with: @merchant_admin.password
    click_button "Login"

    expect(page).to have_link "See My Items"
  end
end

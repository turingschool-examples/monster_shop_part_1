require 'rails_helper'

RSpec.describe "as a user" do
  it "can login with valid credentials" do
    user = User.create(name: "Jordan",
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

  it "cannot login to admin or merchant dashboard if user is default user" do
    user = User.create!(name: "Jordan",
                        address: "394 High St",
                        city: "Denver",
                        state: "CO",
                        zip_code: "80602",
                        email: "hotones@hotmail.com",
                        password: "password",
                        password_confirmation: "password",
                        role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/admin/dashboard"
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit "/merchant/dashboard"
    expect(page).to have_content("The page you were looking for doesn't exist.")

  end

  it "does not allow a default user to see merchant dashboard" do
    user = User.create(name: "Jordan",
      address: "394 High St",
      city: "Denver",
      state: "CO",
      zip_code: "80602",
      email: "hotones@hotmail.com",
      password: "password",
      password_confirmation: "password")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/merchant/dashboard"

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

  describe 'as a merchant' do
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
  describe "all users can log out" do
      it 'can log out as a registered user' do
      user = User.create(name: "Jordan",
                          address: "394 High St",
                          city: "Denver",
                          state: "CO",
                          zip_code: "80602",
                          email: "hotones@hotmail.com",
                          password: "password",
                          password_confirmation: "password",
                          role: 0)

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
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      click_on "Log Out"

      expect(current_path).to eq("/")
      expect(page).to have_content("You have been logged out")
    end
  end
end

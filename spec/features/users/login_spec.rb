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

  it "cannot login with invalid credentials" do
    user = User.create!(name: "Jordan",
                        address: "394 High St",
                        city: "Denver",
                        state: "CO",
                        zip_code: "80602",
                        email: "hotones@hotmail.com",
                        password: "password",
                        password_confirmation: "password",
                        role: 0)

    visit '/login'

    fill_in :email, with: 'prisonmike@gmail.com'
    fill_in :password, with: user.password

    click_button 'Login'

    expect(current_path).to eq('/login')
    expect(page).not_to have_link('Logout')
    expect(page).to have_content('Invalid email or password')

    fill_in :email, with: user.email
    fill_in :password, with: 'jumbalaya'

    expect(current_path).to eq('/login')
    expect(page).not_to have_link('Logout')
    expect(page).to have_content('Invalid email or password')

    fill_in :email, with: 'prisonmike@gmail.com'
    fill_in :password, with: 'jumbalaya'

    expect(current_path).to eq('/login')
    expect(page).not_to have_link('Logout')
    expect(page).to have_content('Invalid email or password')
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
end

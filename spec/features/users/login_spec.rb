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

  describe 'as an admin/merchant/user when logged in' do
    it 'redirects when they visit the login path for admin' do
    admin = User.create(name: "Danny",
                         address: "394 low St",
                         city: "Auora",
                         state: "CO",
                         zip_code: "80221",
                         email: "hottwos@hotmail.com",
                         password: "password2",
                         password_confirmation: "password2",
                         role: 1)


       visit '/login'

       fill_in :email, with: admin.email
       fill_in :password, with: admin.password

       click_button "Login"

       visit '/login'

       expect(current_path).to eq('/admin/dashboard')
       expect(page).to have_content("#{admin.name}, you are already logged in!")
     end

     it 'redirects when they visit the login path for merchant' do

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

        visit '/login'
        expect(current_path).to eq('/merchant/dashboard')
        expect(page).to have_content("#{merchant.name}, you are already logged in!")
      end


     it 'redirects when they visit the login path for a user' do
     user = User.create(name: "Jordan",
                        address: "394 High St",
                        city: "Denver",
                        state: "CO",
                         zip_code: "80602",
                        email: "hotones@hotmail.com",
                        password: "password",
                        password_confirmation: "password",
                        role: 0)

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Login"

      visit '/login'
      expect(current_path).to eq('/profile')
      expect(page).to have_content("#{user.name}, you are already logged in!")
    end
  end
end



# As a registered user, merchant, or admin
# When I visit the login path
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that tells me I am already logged in

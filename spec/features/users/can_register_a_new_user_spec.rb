require "rails_helper"

RSpec.describe "as a visitor" do
  describe "when I click on the register link in the nav bar" do
    it "takes me to user registration page where I see a form with do
    -name
    -street address
    -city
    -state
    -zip
    -email
    -password
    -confirmation for password" do

      visit "/merchants"

      click_link "Register"

      expect(current_path).to eq("/register")

      fill_in :name, with: 'Bob'
      fill_in :address, with: '100 million drive'
      fill_in :city, with: 'denver'
      fill_in :state, with: 'co'
      fill_in :zip, with: 80023
      fill_in :email, with: "bob@bob.com"
      fill_in :password, with: "password"
      fill_in :confirm_password, with: "password"

      click_button "Create New User"

      user = User.last
      expect(current_path).to eq("/profile")
      expect(page).to have_content("Welcome #{user.name}")

      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("#{user.email}")
    end

    describe 'User Registration Missing Details' do
      it 'can display a flash message if fields are missing' do
        visit "/merchants"

        click_link "Register"

        fill_in :name, with: 'Bob'
        fill_in :address, with: ''
        fill_in :city, with: 'denver'
        fill_in :state, with: 'co'
        fill_in :zip, with: 80023
        fill_in :email, with: "bob@bob.com"
        fill_in :password, with: "password"
        fill_in :confirm_password, with: "password"

        click_button "Create New User"

        expect(current_path).to eq("/register")

        expect(page).to have_content('Please complete all required fields')
      end

      it 'fails to register user with non-unique email' do
        user = create :random_user

        visit '/register'

        fill_in :name, with: 'kjhkjhlhkljh'
        fill_in :address, with: '100 million drive'
        fill_in :city, with: 'denver'
        fill_in :state, with: 'co'
        fill_in :zip, with: 80023
        fill_in :email, with: user.email
        fill_in :password, with: "password"
        fill_in :confirm_password, with: "password"

        click_button "Create New User"

        expect(current_path).to eq('/register')

        expect(User.last.name).to_not eq('kjhkjhlhkljh')
      end
    end
  end
end

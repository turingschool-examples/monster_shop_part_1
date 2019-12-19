require 'rails_helper'

RSpec.describe "Navigation" do
  describe "As an Admin user" do
    before :each do
      admin = User.create(
        name: "Joey",
        street_address: "123 Five Street",
        city: "Denver",
        state: "CO",
        zip: "80210",
        email: "fake@gmail.com",
        password: "wordpass",
        role: 1
      )
      # allow_any_instance_of(ApllicationController).to receive(:current_user).and_return(admin)
      visit "/login"

      fill_in :email, with: admin.email
      fill_in :password, with: "wordpass"

      click_on "Sign In"
    end

    it "I see the same links as a visitor" do
      # add additional testing from visitor test

    end

    it "I see a link to admin dashboard, view all users, and no cart info" do
      within ".topnav" do
        expect(page).to have_link('Admin Dashboard')
        expect(page).to have_link('View All Users')

        expect(page).not_to have_content('Cart')
      end
    end
  end
end

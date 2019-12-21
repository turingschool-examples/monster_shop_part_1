require 'rails_helper'

RSpec.describe "user authorization" do
  describe "as a visitor (non registered user)" do
    it "I cannot visit /merchant, /admin, /profile" do

      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/profile'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end

  describe "as a user (registered)" do
    it "I cannot visit /merchant or /admin" do
      user = User.create!(name: "User", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "user@user.com", password: "user", password_confirmation: "user")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end

  describe "as a merchant (admin or employee)" do
    it "I cannot visit /profile or /admin" do
      merchant_admin = User.create!(name: "Merchant Admin", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "merchant_admin@merchant_admin.com", password: "merchant_admin", password_confirmation: "merchant_admin", role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_admin)

      visit '/profile'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
  describe "as an admin" do
    it "I cannot visit /merchant or /cart" do
      admin = User.create!(name: "Admin", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "admin@admin.com", password: "admin", password_confirmation: "admin", role: 3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/cart'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end

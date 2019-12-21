require 'rails_helper'

RSpec.describe "merchant dashboard" do
  describe "as a merchant admin" do
    it "displays the info of the merchant I work for" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      merchant_admin = bike_shop.users.create!(name: "Merchant Admin", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "merchant_admin@merchant_admin.com", password: "merchant_admin", password_confirmation: "merchant_admin", role: 2)

      allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(merchant_admin)

      visit '/merchant'

      expect(page).to have_content(bike_shop.name)
      expect(page).to have_content(bike_shop.address)
      expect(page).to have_content(bike_shop.city)
      expect(page).to have_content(bike_shop.state)
      expect(page).to have_content(bike_shop.zip)
    end
  end

  describe "as a merchant employee" do
    it "displays the info of the merchant I work for" do
      ski_shop = Merchant.create(name: "Ski Palace", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      merchant_employee = ski_shop.users.create!(name: "Merchant Employee", address: "1230 East Street", city: "Boulder", state: "CO", zip: 98273, email: "merchant_employee@merchant_employee.com", password: "merchant_employee", password_confirmation: "merchant_employee", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(page).to have_content(ski_shop.name)
      expect(page).to have_content(ski_shop.address)
      expect(page).to have_content(ski_shop.city)
      expect(page).to have_content(ski_shop.state)
      expect(page).to have_content(ski_shop.zip)
    end
  end
end

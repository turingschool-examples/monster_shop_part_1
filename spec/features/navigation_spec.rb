
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'
      within 'nav' do
        click_link "Cart: 0"
      end
      expect(current_path).to eq("/cart")

      visit '/items'
      within 'nav' do
        click_link "Cart: 0"
      end
      expect(current_path).to eq("/cart")
    end

    it "has link to return to home page" do
      visit "/items"

      within "nav" do
        click_link ("Monster Shop")

        expect(current_path).to eq("/")
      end
    end

    it "has login and register links" do
      visit "/merchants"

      within "nav" do
        click_link "Login"
        expect(current_path).to eq("/login")
      end

      within "nav" do
        click_link "Register"
        expect(current_path).to eq("/register")
      end
    end
  end
  describe 'as a registered regular user' do
    it 'shows same links as visitor plus link to profile and logout' do
      user = create(:random_user, role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      expect(page).to have_link("Profile")
      expect(page).to have_link("Log Out")

      expect(page).to have_link("Monster Shop")
      expect(page).to have_link("All Items")
      expect(page).to have_link("All Merchants")
      expect(page).to have_link("Cart: 0")

      expect(page).not_to have_link("Login")
      expect(page).not_to have_link("Register")

      expect(page).to have_content("Logged in as #{user.name}")
    end
  end
  describe 'as a merchant' do
    it 'shows same links as any registered user plus link to merchant dashboard' do
      user = create(:random_user, role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to have_link("Profile")
      expect(page).to have_link("Log Out")
      expect(page).to have_link("Monster Shop")
      expect(page).to have_link("All Items")
      expect(page).to have_link("All Merchants")
      expect(page).to have_link("Cart: 0")
      expect(page).to have_content("Logged in as #{user.name}")

      expect(page).not_to have_link("Login")
      expect(page).not_to have_link("Register")

      expect(page).to have_link("Merchant Dashboard")
    end
  end
end

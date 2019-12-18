
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
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
		end

		it "I can see the registration link in the nav bar" do

			visit '/merchants'

			within 'nav' do
				expect(page).to have_content("Register")
			end

			click_on 'Register'

			expect(current_path).to eq("/register")
		end

		it "I can see the welcome link in the nav bar" do

			visit '/merchants'

			within 'nav' do
				expect(page).to have_content("Welcome")
			end

			click_on 'Welcome'

			expect(current_path).to eq("/")
		end

		it "I can see the Login link in the nav bar" do

			visit '/merchants'

			within 'nav' do
				expect(page).to have_content("Login")
			end

			click_on 'Login'

			expect(current_path).to eq("/login")
		end
  end
end

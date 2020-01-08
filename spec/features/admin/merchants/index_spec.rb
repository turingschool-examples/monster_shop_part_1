require 'rails_helper'

RSpec.describe 'merchant index page', type: :feature do
  describe 'As an admin user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
      @item = create :item, merchant: @bike_shop
      @admin = create :random_admin_user

      visit '/login'

      fill_in :email, with: @admin.email
      fill_in :password, with: 'password'

      click_button 'Log In'
    end

    it 'I can see a list of merchants in the system and their city and state' do
      visit '/admin/merchants'

      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_link("Brian's Bike Shop")
        expect(page).to have_content("Richmond")
        expect(page).to have_content("VA")
      end

      within "#merchant-#{@dog_shop.id}" do
        expect(page).to have_link("Meg's Dog Shop")
        expect(page).to have_content("Hershey")
        expect(page).to have_content("PA")
      end
    end

    it 'I can see a link to create a new merchant' do
      visit '/admin/merchants'

      expect(page).to have_link("New Merchant")

      click_on "New Merchant"

      expect(current_path).to eq("/merchants/new")
    end

    it 'I can disable a merchant' do
      # visit '/login'
      #
      # fill_in :email, with: @admin.email
      # fill_in :password, with: 'password'
      #
      # click_button 'Log In'

      visit '/admin/merchants'

      within "#merchant-#{@bike_shop.id}" do
        click_button 'Deactivate'
      end
      expect(page).to have_content("Merchant Deactivated")
      expect(current_path).to eq('/admin/merchants')

      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_button('Activate')
      end

      visit '/items'

      expect(page).to_not have_content(@bike_shop.items.first.name)
    end

    it 'can activate merchant as admin' do

      visit '/admin/merchants'

      within "#merchant-#{@bike_shop.id}" do
        click_button 'Deactivate'
      end

      within "#merchant-#{@bike_shop.id}" do
        click_button 'Activate'
      end

      expect(page).to have_content('Merchant Activated')

      visit '/items'

      expect(page).to have_content(@bike_shop.items.first.name)
    end
  end
end

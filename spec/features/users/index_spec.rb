require 'rails_helper'

RSpec.describe 'index /profile', type: :feature do
	describe 'As a user' do
		before :each do
			@kevin = User.create!(name: "Kevin", street_address: "1234 Fake st.", city: "Denver", state: "Colorado", zip: 80230, email: "kevin@fakemail.com", password: "fakemcfackerson")
			@alex = User.create!(name: "Alex", street_address: "4567 Fake st.", city: "Denver", state: "Colorado", zip: 80221, email: "alex@fakemail.com", password: "fakemcfackersonthesecond")
		end

		it 'I can see the users name, address, city, state, email' do

			visit '/users'

			expect(page).to have_content(@kevin.name)
			expect(page).to have_content(@kevin.street_address)
			expect(page).to have_content(@kevin.city)
			expect(page).to have_content(@kevin.state)
			expect(page).to have_content(@kevin.zip)
			expect(page).to have_content(@kevin.email)

			expect(page).to have_content(@alex.name)
			expect(page).to have_content(@alex.street_address)
			expect(page).to have_content(@alex.city)
			expect(page).to have_content(@alex.state)
			expect(page).to have_content(@alex.zip)
			expect(page).to have_content(@alex.email)
		end
	end
end

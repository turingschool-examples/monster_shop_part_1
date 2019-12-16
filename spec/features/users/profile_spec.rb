require 'rails_helper'

RSpec.describe 'user profile page', type: :feature do
	describe 'As a user' do
		before :each do
			@sebastian = User.create!(name: "Sebastian", street_address: "8901 Fake st.", city:"Denver", state: "Colorado", zip: 80235, email: "sebastian@fake.com", password_digest: "Originalfaker")
		end

		it "I can see the individual user information." do

			visit "/users/#{@sebastian.id}"

			expect(page).to have_content(@sebastian.name)
			expect(page).to have_content(@sebastian.street_address)
			expect(page).to have_content(@sebastian.city)
			expect(page).to have_content(@sebastian.state)
			expect(page).to have_content(@sebastian.zip)
			expect(page).to have_content(@sebastian.email)
		end
	end
end

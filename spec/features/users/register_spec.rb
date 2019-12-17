require "rails_helper"

describe 'new user' do
	it 'I should be able to register as a new user' do

		visit '/'

		click_on 'Register as a User'

		expect(current_path).to eq("/users/new")

		name = "Ryan Allen"
		street_address = "45433 fake st."
		city = "Denver"
		state = "Colorado"
		zip = 80234
		email = "ryan@fake.com"
		password = "BestFakerEver"

		fill_in :name, with: name
		fill_in :street_address, with: street_address
		fill_in :city, with: city
		fill_in :state, with: state
		fill_in :zip, with: zip
		fill_in :email, with: email
		fill_in :password, with: password

		click_on 'Create User'

		expect(page).to have_content("Welcome, #{name}")
		expect(page).to have_content(street_address)
		expect(page).to have_content(city)
		expect(page).to have_content(state)
		expect(page).to have_content(zip)
		expect(page).to have_content(email)
	end
end

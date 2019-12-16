require "rails_helper"

describe 'new user' do
	it 'I should be able to register as a new user' do

		visit '/merchants'

		click_on 'Register'

		expect(current_path).to eq("/register")
		expect(page).to have_content("Name")
		expect(page).to have_content("City")
		expect(page).to have_content("State")
		expect(page).to have_content("Zip")
		expect(page).to have_content("Email")
		expect(page).to have_content("Password")

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

		click_on 'Register User'

		new_user = User.last

		expect(current_path).to eq("/users")
		# expect(page).to have_content(name)
	end
end

RSpec.describe "User registration form" do

  it "keeps a user logged in after registering" do
		@alex = User.create!(name: "Alex", street_address: "4567 Fake st.", city: "Denver", state: "Colorado", zip: 80221, email: "alex@fakemail.com", password: "fakemcfackersonthesecond")

    visit "/"

    click_on "Register as a User"

    name = @alex.name
    street_address = @alex.street_address
    city = @alex.city
    state = @alex.state
  	zip = @alex.zip
  	email = @alex.email
    password = @alex.password

    fill_in :name, with: name
    fill_in :street_address, with: street_address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    fill_in :email, with: email
    fill_in :password, with: password

    # click_on "Create User"
		#
		# expect(current_path).to eq("/users")


  end
end

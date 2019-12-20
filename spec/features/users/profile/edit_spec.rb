require 'rails_helper'

RSpec.describe "As a default user" do
  let!(:user) { create(:user, :default_user) }
  before {
    visit "/login"

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Sign In"
  }

  context 'when I visit my dashboard' do
    it 'it should display content relevant to my role' do
      expect(page).to have_content("User Profile")
    end
  end

	it "I can edit my profile Infromation " do

		click_on 'Edit Profile'

		expect(current_path).to eq("/users/profile/edit")
		expect(page).to have_content("Name")
		expect(page).to have_content("Street address")
		expect(page).to have_content("City")
		expect(page).to have_content("State")
		expect(page).to have_content("Zip")
		expect(page).to have_content("Email")

		fill_in :name, with: "edit test"
		fill_in :name, with: "6678 fake st."
		fill_in :name, with: "Arvada"
		fill_in :name, with: "Washington"
		fill_in :name, with: "56890"
		fill_in :name, with: "edittest@fake.com"

		click_on "Update"

		expect(current_path).to eq("/users/profile")
	end
end

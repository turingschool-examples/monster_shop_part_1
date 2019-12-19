require "rails_helper"

RSpec.describe "As a registered user" do
  it "can edit a user's profile" do

    user = create(:random_user, role: 0)

    visit '/'

    click_link "Login"
    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login"

    click_link("Edit Profile")
    expect(current_path).to eql("/profile/edit")

    fill_in :name, with: "Mojo Jojojo"
    fill_in :address, with: "123 Powerpuff Lane"
    fill_in :city, with: "Townsville"
    fill_in :state, with: "USA"
    fill_in :zip, with: "12345"

    click_on "Submit"
    expect(current_path).to eql("/profile")

    expect(page).to have_content("You have successfully edited your profile!")

    expect(page).to have_content("Name: Mojo Jojojo")
    expect(page).to have_content("Address: 123 Powerpull Lane")
    expect(page).to have_content("City: Townsville")
    expect(page).to have_content("State: USA")
    expect(page).to have_content("Zip Code: 12345")
    expect(page).to have_content("Email: #{user.email}")

  end
end

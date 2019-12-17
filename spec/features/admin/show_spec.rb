require 'rails_helper'

RSpec.describe "As an admin" do
  it "" do
    admin = User.create(
      name: "Joey",
      street_address: "123 Five Street",
      city: "Denver",
      state: "CO",
      zip: "80210",
      email: "fake@gmail.com",
      password: "wordpass",
      role: 1
    )

    # allow_any_instance_of(ApllicationController).to receive(:current_user).and_return(admin)

    visit "/login"

    fill_in :email, with: admin.email
    fill_in :password, with: "wordpass"

    click_on "Login"

    expect(current_path).to eq("/admin/profile")
    expect(page).to have_content("Welcome, user. You are the Admin.")
  end
end

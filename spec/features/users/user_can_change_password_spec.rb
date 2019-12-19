require 'rails_helper'

RSpec.describe "a user can visit their profile page" do
  it "can click a link to change their password" do
    user = create(:random_user)

    visit "/login"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login"

    visit "/profile"

    click_link("Change Password")
    expect(current_path).to eq()

  end
end

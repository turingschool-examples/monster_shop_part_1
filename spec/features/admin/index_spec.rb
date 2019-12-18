require 'rails_helper'

RSpec.describe "As an admin" do
  it "it can login and be redirected to admin dashboard" do
    user = create(:random_user, role: 1)
  
    visit '/'

    click_link "Login"
    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Login"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Welcome, #{user.name}, you are logged in!")
  end
end

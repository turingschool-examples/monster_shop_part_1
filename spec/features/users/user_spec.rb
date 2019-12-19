require 'rails_helper'

RSpec.describe 'As a user' do
  it 'does not allow me to go to merchant or admin pages' do

    user = create(:random_user, role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(user.role).to eq("default")

    visit '/admin/dashboard'
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

    visit '/merchant/dashboard'
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

  end

  it "can see the user's profile" do

    user = create(:random_user, role: 0)

    visit '/'

    click_link "Login"
    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Login"

    expect(page).to have_content("#{user.name}")
    expect(page).to have_content("#{user.address}")
    expect(page).to have_content("#{user.city}")
    expect(page).to have_content("#{user.state}")
    expect(page).to have_content("#{user.zip_code}")
    expect(page).to have_content("#{user.email}")

    expect(page).to have_link("Edit Profile")
    save_and_open_page

  end
end

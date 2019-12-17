require 'rails_helper'

RSpec.describe "As an admin" do
  it "it can login and be redirected to admin dashboard" do
    user = User.create!(name: "Jordan",
                        address: "394 High St",
                        city: "Denver",
                        state: "CO",
                        zip_code: "80602",
                        email: "hotones@hotmail.com",
                        password: "password",
                        password_confirmation: "password",
                        role: 1)
    


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

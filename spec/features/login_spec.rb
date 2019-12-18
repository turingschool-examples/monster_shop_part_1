# require 'rails_helper'
#
# RSpec.describe "As a visitor" do
#   describe "when I click 'login' it sends me to a login page" do
#     it "has fields to enter my email and password" do
#
#
#       visit "/login"
#
#       fill_in :email, with: "fake@gmail.com"
#       fill_in :password, with: "fakepassword"
#
#       click_button "Login"
#
#       expect(current_path).to eq("login/#{user.id}")
#       expect(page).to have_content("Hello, #{user.name}")
#     end
#   end
# end


# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in

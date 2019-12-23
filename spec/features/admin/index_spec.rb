require 'rails_helper'

RSpec.describe "As an admin" do
  it "can login and be redirected to admin dashboard" do
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
  it "can see all orders, their id, date created and status" do
    user = create(:random_user, role: 1)

    visit '/'

    click_link "Login"
    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Login"

    expect(page).to have_content()
    expect(page).to have_content()
    expect(page).to have_content()
    
  end

  User Story 32, Admin can see all orders

As an admin user
When I visit my admin dashboard ("/admin")
Then I see all orders in the system.
For each order I see the following information:

- user who placed the order, which links to admin view of user profile
- order id
- date the order was created

Orders are sorted by "status" in this order:

- packaged
- pending
- shipped
- cancelled
end

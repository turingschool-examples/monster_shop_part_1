RSpec.describe "User registration form" do

  it "keeps a user logged in after registering" do
    visit "/"

    click_on "Register as a User"

    name = "funbucket13"
    password = "test"

    fill_in :name, with: name
    fill_in :password, with: password

    click_on "Create User"

    visit '/profile'

    expect(page).to have_content("Hello, #{name}!")
  end
end

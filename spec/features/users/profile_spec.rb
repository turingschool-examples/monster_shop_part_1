RSpec.describe "User registration form" do

  it "keeps a user logged in after registering" do
    visit "/"

    click_on "Register as a User"

    user_name = "funbucket13"
    password = "test"

    fill_in :name, with: user_name
    fill_in :password, with: password

    click_on "Create User"

  end
end

require 'rails_helper'

RSpec.describe 'User Can Edit their Profile Data' do
  it 'by clicking an edit link when visiting their profile page' do
    user = User.create(
      name: 'Granicus Higgins',
      email: 'lol@ex.com',
      address: '123 mail',
      city: 'Denver',
      state: 'CO',
      zip: '80123',
      password: 'pass123'
    )

    visit '/login'
    fill_in :email, with: user.email
    fill_in :password, with: 'pass123'
    click_button 'Log In'

    click_link 'Edit Profile'
    expect(current_path).to eq("/users/#{user.id}/edit")

    expect(page).to have_selector("input[value='Granicus Higgins']")
    expect(page).to have_selector("input[value='lol@ex.com']")
    expect(page).to have_selector("input[value='123 mail']")
    expect(page).to have_selector("input[value='Denver']")
    expect(page).to have_selector("input[value='CO']")
    expect(page).to have_selector("input[value='80123']")

    fill_in 'Name', with: 'Harry Potter'
    fill_in 'Address', with: '456 Larimer street'
    fill_in 'City', with: 'Cheyenne'
    fill_in 'State', with: 'Wyoming'
    fill_in 'Zip', with: '46384'

    click_button 'Save Changes'

    expect(current_path).to eq("/profile")
    expect(page).to have_content('Harry Potter')
    expect(page).to have_content('456 Larimer street')
    expect(page).to have_content('Cheyenne')
    expect(page).to have_content('Wyoming')
    expect(page).to have_content('46384')
  end

  it "but if they try use an email address belonging to another use,
      it displays a flash message and returns the user to the profile edit page" do

    user = User.create(
      name: 'Granicus Higgins',
      email: 'lol@ex.com',
      address: '123 mail',
      city: 'Denver',
      state: 'CO',
      zip: '80123',
      password: 'pass123'
    )

    user_2 = User.create(
      name: 'Harry Potter',
      email: 'yolo@spells.com',
      address: '456 Larimer street',
      city: 'Denver',
      state: 'CO',
      zip: '80123',
      password: 'pass123'
    )

    visit '/login'
    fill_in :email, with: user.email
    fill_in :password, with: 'pass123'
    click_button 'Log In'

    click_link 'Edit Profile'

    fill_in 'Email', with: user_2.email
    click_button 'Save Changes'

    expect(current_path).to eq("/users/#{user.id}/edit")
    expect(page).to have_content('Email address already in use by another user, please enter a different email address')

    expect(page).to have_selector("input[value='Granicus Higgins']")
    expect(page).to have_selector("input[value='lol@ex.com']")
    expect(page).to have_selector("input[value='123 mail']")
    expect(page).to have_selector("input[value='Denver']")
    expect(page).to have_selector("input[value='CO']")
    expect(page).to have_selector("input[value='80123']")
  end
end

# As a registered user
# When I attempt to edit my profile data
# If I try to change my email address to one that belongs to another user
# When I submit the form
# Then I am returned to the profile edit page
#
#  And I see a flash message telling me that email address is already in use

# User Story 20, User Can Edit their Profile Data
#
# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# I see a form like the registration page
# The form is prepopulated with all my current information except my password
# When I change any or all of that information
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information

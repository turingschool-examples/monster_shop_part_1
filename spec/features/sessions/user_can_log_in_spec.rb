require 'rails_helper'

RSpec.describe 'when a user logs in', type: :feature do
  before :each do
    User.destroy_all
    @user = User.create(
      name: 'Granicus Higgins',
      email: 'lol@ex.com',
      address: '123 mail',
      city: 'Denver',
      state: 'CO',
      zip: '80123',
      password: 'pass123'
    )
  end

  it 'will log in user and create new session' do
    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'pass123'

    click_button 'Log In'
    expect(current_path).to eq('/profile')
    expect(page).to have_content("Welcome, #{@user.name}")
  end

  it 'will fail to log in if password is incorrect' do
    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'sdfssdc23'

    click_button 'Log In'
    expect(current_path).to eq('/login')
    expect(page).to have_content('Credentials were incorrect')
  end

end

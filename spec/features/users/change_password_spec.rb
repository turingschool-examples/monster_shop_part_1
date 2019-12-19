require 'rails_helper'

RSpec.describe 'when I visit the update password form', type: :feature do
  before :each do
    @user = create :random_reg_user_test

    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'password'

    click_button 'Log In'
    visit '/user/edit-pw'
  end

  it 'will fail to update if current pw is incorrect' do

    fill_in :current_password, with: 'notpassword'
    fill_in :new_password, with: 'newpass'
    fill_in :confirm_new_password, with: 'newpass'

    click_button 'Update Password'

    expect(page).to have_content('Incorrect password, please try again')
  end

  it 'will fail to update password if new password and confirmation do not match' do

    fill_in :current_password, with: 'password'
    fill_in :new_password, with: 'newpass'
    fill_in :confirm_new_password, with: 'newpasssfssfd'

    click_button 'Update Password'

    expect(page).to have_content("Passwords don't match")
  end

  it 'will fail to update password if new password and confirmation do not match' do

    fill_in :current_password, with: 'password'
    fill_in :new_password, with: 'newpass'
    fill_in :confirm_new_password, with: 'newpass'

    click_button 'Update Password'

    expect(current_path).to eq('/profile')
    expect(page).to have_content('Password updated successfully')
  end


end

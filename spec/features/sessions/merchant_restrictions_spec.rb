require 'rails_helper'

RSpec.describe 'As a merchant', type: :feature do
  before :each do
    @user = create :random_user
    @user.update(role: 2)
    current_user = @user.id
  end

  it 'is a merchant' do
    expect(@user.merchant?)
  end

  it 'will prevent me from visiting /admin' do
    visit '/admin'
    expect(page).to have_content('404 Page Not Found')

    visit '/admin/dashboard'
    expect(page).to have_content('404 Page Not Found')
  end

  it 'will prevent me from visiting /profile' do
    visit '/profile'
    expect(page).to have_content('404 Page Not Found')
  end
end

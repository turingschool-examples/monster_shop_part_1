require 'rails_helper'

RSpec.describe 'As a regular user', type: :feature do
  before :each do
    @user = create :random_user
    @user.update(role: 1)
    current_user = @user.id
  end

  it 'will prevent me from visiting /merchant' do
    visit '/merchant'
    expect(page).to have_content('404 Page Not Found')

    visit '/merchant/dashboard'
    expect(page).to have_content('404 Page Not Found')
  end

  it 'will prevent me from visiting /cart' do
    visit '/cart'
    expect(page).to have_content('404 Page Not Found')
  end
end

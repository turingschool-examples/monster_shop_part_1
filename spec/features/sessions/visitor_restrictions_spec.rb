require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  it 'will prevent me from visiting /admin' do
    visit '/admin'
    expect(page).to have_content('404 Page Not Found')

    visit '/admin/dashboard'
    expect(page).to have_content('404 Page Not Found')
  end

  it 'will prevent me from visiting /merchant' do
    visit '/merchant'
    expect(page).to have_content('404 Page Not Found')

    visit '/merchant/dashboard'
    expect(page).to have_content('404 Page Not Found')
  end

  it 'will prevent me from visiting /profile' do
    visit '/profile'
    expect(page).to have_content('404 Page Not Found')
  end
end

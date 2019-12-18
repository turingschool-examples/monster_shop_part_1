require 'rails_helper'

RSpec.describe 'As a user' do
  it 'does not allow me to go to merchant or admin pages' do

    user = create(:random_user, role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(user.role).to eq('default')

    visit '/admin/dashboard'
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

    visit '/merchant/dashboard'
    expect(page).to have_content("The page you were looking for doesn't exist (404)")

  end
end

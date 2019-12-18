require 'rails_helper'

RSpec.describe 'when a visit a path with no route', type: :feature do
  it 'should render a 404 page' do
    visit '/sdfsdfsfd'

    expect(page).to have_content('404 Page Not Found')
  end
end

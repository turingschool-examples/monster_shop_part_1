require 'rails_helper'

RSpec.describe 'As a visitor' do
  it "can click on register link in the nav bar" do
    visit '/'

    within 'nav' do
      click_link 'Register'
    end

    expect(current_path).to eq('/register')
  end
end
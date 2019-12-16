require 'rails_helper'

RSpec.describe 'new /register', type: :feature do
  context 'user visits the page' do
    before { visit '/register' }
    
    it 'should have a form' do
      expect(page).to have_selector("form")
    end

    context 'user form data is valid' do

      it 'should redirect the user to /profile when register button is clicked' do
        click_button 'Register'
        expect(current_path).to eq("/profile")
      end

    end

    context 'user form data is invalid' do

    end
  end
end
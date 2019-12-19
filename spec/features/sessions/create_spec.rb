require 'rails_helper'

RSpec.describe 'User logging in' do
  let(:user) { create(:user, :default_user) }
  let(:admin) { create(:user, :admin_user) }
  let(:merchant) { create(:user, :merchant_user) }
  before {
    visit "/login"
  }

  context 'with valid credentials' do
    context 'user is an admin' do
      before {
        fill_in :email, with: admin.email
        fill_in :password, with: admin.password
    
        click_on "Sign In"
      }
      it 'they can sign in' do
        expect(current_path).to eq("/admin/profile")
      end

      it 'they see a welcome flash message' do
        within("#main-flash") do
          expect(page).to have_content("Welcome, #{admin.name}. You are logged in as an Admin.")
          expect(page).to_not have_content("Welcome, #{merchant.name}. You are logged in as a Merchant.")
          expect(page).to_not have_content("Welcome, #{user.name}.")
        end
      end
    end

    context 'user is a merchant' do
      before {
        fill_in :email, with: merchant.email
        fill_in :password, with: merchant.password
    
        click_on "Sign In"
      }
      it 'they can sign in' do
        expect(current_path).to eq("/merchants/profile")
      end

      it 'they see a welcome flash message' do
        within("#main-flash") do
          expect(page).to have_content("Welcome, #{merchant.name}. You are logged in as a Merchant.")
          expect(page).to_not have_content("Welcome, #{admin.name}. You are logged in as an Admin.")
          expect(page).to_not have_content("Welcome, #{user.name}.")
        end
      end
    end

    context 'user is a default user' do
      before {
        fill_in :email, with: user.email
        fill_in :password, with: user.password
    
        click_on "Sign In"
      }
      it 'they can sign in' do
        expect(current_path).to eq("/users/profile")
      end

      it 'they see a welcome flash message' do
        within("#main-flash") do
          expect(page).to have_content("Welcome, #{user.name}.")
          expect(page).to_not have_content("Welcome, #{admin.name}. You are logged in as an Admin.")
          expect(page).to_not have_content("Welcome, #{merchant.name}. You are logged in as a Merchant.")
        end
      end
    end
  end

  context 'with invalid credentials' do
    xit 'prevents them from logging in' do

    end

    xit 'displays a flash message warning' do

    end
  end
end
require 'rails_helper'

RSpec.describe "user authorization" do
  describe "as a visitor (non registered user)" do
    it "I cannot visit /merchant, /admin, /profile" do

      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")

      visit '/profile'

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end

require "rails_helper"

RSpec.describe "as a merchant" do 
  describe "when I am logged in and on dashboard page (/merchant)" do 
    it "merchant dashboard show page shows me 1) Name and 2) Full address of the merchant I work for " do 

      @merchant_user = User.create!(name: "show merch", address: "show", city: "denver", state: "co", zip: 80023, role: 2, email: "joe@ge.com", password: "password") 
      
      @target = create :merchant

      @target.users << @merchant_user
      
      visit '/login'

      fill_in :email, with: @merchant_user.email
      fill_in :password, with: 'password'

      click_button 'Log In'

      visit '/merchant/dashboard'

      within "#merchant_dashboard-#{@merchant_user.merchant_id}" do 
        expect(page).to have_content(@target.name)
        expect(page).to have_content(@target.address)
        expect(page).to have_content(@target.city)
        expect(page).to have_content(@target.state)
        expect(page).to have_content(@target.zip)
      end
    end 
    it "shows me a list of orders pending that I sell (if any) in a list -
        the ID of the order, which is a link to the order show page /merchant/orders/15)
        the date the order was made
        the total quantity of my items in the order
        the total value of my items for that order" do 

      @merchant_user = User.create!(name: "show merch", address: "show", city: "denver", state: "co", zip: 80023, role: 2, email: "joe@ge.com", password: "password") 
      
      @target = create :merchant

      @target.users << @merchant_user
      
      visit '/login'

      fill_in :email, with: @merchant_user.email
      fill_in :password, with: 'password'

      click_button 'Log In'

      visit '/merchant/dashboard'
      
      expect(page).to have_content()
    
      
  end
end


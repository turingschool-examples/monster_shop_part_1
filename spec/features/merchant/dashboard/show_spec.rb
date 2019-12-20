require "rails_helper"

RSpec.describe "as a merchant" do 
  it "merchant dashboard show page shows me 1) Name and 2) Full address of the merchant I work for " do 

    @merchant_user = User.create!(name: "show merch", address: "show", city: "denver", state: "co", zip: 80023, role: 2, email: "joe@ge.com", password: "password") 
    
    @target = create :merchant

    @target.users << @merchant_user
    # has many 
    
    visit '/login'

    fill_in :email, with: @merchant_user.email
    fill_in :password, with: 'password'

    click_button 'Log In'

    visit '/merchant/dashboard'

    expect(page).to have_content(@target.name)
    expect(page).to have_content(@target.address)
    expect(page).to have_content(@target.city)
    expect(page).to have_content(@target.state)
    expect(page).to have_content(@target.zip)
  end 
end 


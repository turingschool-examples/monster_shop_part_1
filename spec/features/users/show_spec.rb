require 'rails_helper'

RSpec.describe "As a registered user and visit my profile page" do
  before :each do
    @user = User.create(
      name: 'Granicus Higgins',
      email: 'lol@ex.com',
      address: '123 mail',
      city: 'Denver',
      state: 'CO',
      zip: '80123',
      password: 'pass123'
      )
  end
end

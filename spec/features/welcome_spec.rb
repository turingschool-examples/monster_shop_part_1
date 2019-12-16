require 'rails_helper'

RSpec.describe "Welcome page" do
  it "can visit the welcome page" do
    visit "/"
    expect(page).to have_content("Welcome to Monster Shop")
  end
end

require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
    it {should validate_presence_of :password_confirmation}
  end

  describe 'relationships' do
    it 'has an optional attribute of merchant_id' do
      merchant = User.create!(name: "Ima Merchant",
                              address: "1230 East Street",
                              city: "Boulder",
                              state: "CO",
                              zip: 98273,
                              email: "veryoriginalemail@gmail.com",
                              password: "polyester",
                              password_confirmation: "polyester",
                              role: 2)

      expect(User.find(merchant.id)).to eq(merchant)
      expect(User.find(merchant.id).merchant).to eq(nil)

      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      merchant2 = meg.users.create!(name: "Ima Merchant",
                              address: "1230 East Street",
                              city: "Boulder",
                              state: "CO",
                              zip: 98273,
                              email: "differentemail@gmail.com",
                              password: "polyester",
                              password_confirmation: "polyester",
                              role: 2)

      expect(merchant2.merchant).to eq(meg)
    end
  end

  describe 'roles' do
    it "can be created as a default user" do
      user = User.create!(name: "Normal Person",
                              address: "1230 East Street",
                              city: "Boulder",
                              state: "CO",
                              zip: 98273,
                              email: "veryoriginalemail@gmail.com",
                              password: "polyester",
                              password_confirmation: "polyester")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(user.role).to eq('user')
      expect(user.user?).to be_truthy
    end

    it "can be created as a merchant" do
      merchant = User.create!(name: "Ima Merchant",
                              address: "1230 East Street",
                              city: "Boulder",
                              state: "CO",
                              zip: 98273,
                              email: "veryoriginalemail@gmail.com",
                              password: "polyester",
                              password_confirmation: "polyester",
                              role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      expect(merchant.role).to eq('merchant_admin')
      expect(merchant.merchant_admin?).to be_truthy
    end
  end
end

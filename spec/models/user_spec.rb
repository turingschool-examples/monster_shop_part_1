require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe 'relationships' do
    it { should have_many :orders}
    it {should belong_to(:merchant).optional}
  end

  describe 'roles' do
    it "can be created as a default user" do
      user = User.create!(name: "Jordan",
                          address: "394 High St",
                          city: "Denver",
                          state: "CO",
                          zip_code: "80602",
                          email: "hotones@hotmail.com",
                          password: 'dementors',
                          password_confirmation: 'dementors',
                          role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it "can be created as admin" do
      user = User.create!(name: "Jordan",
                          address: "394 High St",
                          city: "Denver",
                          state: "CO",
                          zip_code: "80602",
                          email: "hotones@hotmail.com",
                          password: 'dementors',
                          password_confirmation: 'dementors',
                          role: 1)

      expect(user.role).to eq('admin')
      expect(user.admin?).to be_truthy
    end

    it "can be created as a merchant user" do
      user = User.create!(name: "Jordan",
                          address: "394 High St",
                          city: "Denver",
                          state: "CO",
                          zip_code: "80602",
                          email: "hotones@hotmail.com",
                          password: 'dementors',
                          password_confirmation: 'dementors',
                          role: 2)

      expect(user.role).to eq('merchant_admin')
      expect(user.merchant_admin?).to be_truthy
    end
  end
end

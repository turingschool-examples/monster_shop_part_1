class User < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip, :email, :password

	validates :name, uniqueness: true, presence: true
	validates :email, uniqueness: true, presence: true
	validates_presence_of :password, require: true

	has_secure_password 
end

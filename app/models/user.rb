class User < ApplicationRecord
  validate_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true

  has_secure_password 
end

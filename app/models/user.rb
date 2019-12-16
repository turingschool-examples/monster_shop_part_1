class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :password_confirmation, require: true
  validates_presence_of :name, :address, :city, :state, :zip_code

  has_secure_password
end
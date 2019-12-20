class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true, :on => :create
  validates_presence_of :password_confirmation, require: true, :on => :create

  has_many :orders
  
  has_secure_password

  enum role: ["user", "merchant_employee", "merchant_admin", "admin"]

end

class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def self.status(status_searching_for)
    # can take argument of "packaged", "pending", "shipped", or "cancelled"
    where(status: "#{status_searching_for}")
  end
end

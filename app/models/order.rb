class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :current_status

  has_many :item_orders
  has_many :items, through: :item_orders

  belongs_to :user

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def cancel
    update(current_status: "CANCELLED")
    ItemOrder.all.update(status: 1)
  end
end

class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def self.most_popular
    ItemOrder.select(:sum).group(:item).sum(:quantity)
    require "pry"; binding.pry
    # select item_id, sum(quantity) FROM item_orders GROUP BY item_id ORDER BY sum desc;
  end
end

class AddFulfilledByMerchantToItemOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :item_orders, :fulfilled_by_merchant, :boolean, default: false
  end
end

class AddCurrentStatustoOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :current_status, :string, default: "PENDING"
  end
end

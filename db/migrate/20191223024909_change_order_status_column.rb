class ChangeOrderStatusColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :current_status
    add_column :orders, :current_status, :integer, default: 0
  end
end

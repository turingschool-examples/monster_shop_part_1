class OrderStatusController < ApplicationController
  def update
    order = Order.find(params[:id])
    if (params[:status] == 'cancelled') && order.status != 'Shipped'
      order.update(status: 3)
      flash[:happy] = 'Your order has been cancelled'
      redirect_back fallback_location: "/profile/orders/#{order.id}"
    elsif params[:status] == 'shipped'
      order.update(status: 2)
      flash[:happy] = 'Order has been shipped'
      redirect_to '/admin/dashboard'
    end
  end
end

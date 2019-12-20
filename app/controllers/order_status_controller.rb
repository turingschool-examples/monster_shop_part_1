class OrderStatusController < ApplicationController
  def update
    order = Order.find(params[:id])
    if (params[:status] == 'cancelled') && order.status != 'Shipped'
      order.update(status: 3)
      flash[:happy] = 'Your order has been cancelled'
      redirect_back fallback_location: "/profile/orders/#{order.id}"
    end
  end
end

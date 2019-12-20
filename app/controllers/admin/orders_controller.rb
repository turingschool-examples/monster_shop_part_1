class Admin::OrdersController < Admin::BaseController

  def update
    Order.update(params[:id], status: 2)

    redirect_to '/admin'
  end
end

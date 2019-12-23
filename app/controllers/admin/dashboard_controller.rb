class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def update
  end
end

class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @merchant_active_orders = @merchant.orders.where(status:"Pending").distinct 
  end
end

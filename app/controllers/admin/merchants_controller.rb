class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_active_orders = @merchant.orders.where(status:"Pending").distinct 
  end 
   
end

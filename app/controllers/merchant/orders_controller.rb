class Merchant::OrdersController < Merchant::BaseController
  
  def index 
  end 

  def show 
    @current_order = Order.find(params[:id])
  end 
end 

class OrdersController <ApplicationController

  def new

  end

  def show
    @order = Order.find(params[:id])
    # require "pry"; binding.pry
  end

  def create
    order = Order.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      redirect_to "/profile/orders"
      flash[:notice] = "Your order was created!"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def index
    @orders = Order.all

  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end

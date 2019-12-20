class OrdersController < ApplicationController

  def new

  end



  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.create(order_params)
    current_user.orders << order
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      redirect_to "/orders/#{order.id}"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def index

  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def by_user_type
    if !current_user
      render 'errors/404'
    elsif current_user.admin?
      @orders = Order.all
    elsif current_user
      @orders = current_user.orders
    end
  end
end

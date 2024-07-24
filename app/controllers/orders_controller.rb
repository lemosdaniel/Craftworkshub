class OrdersController < ApplicationController
  before_action :set_cart

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def create
    @order = @cart.build_order(order_params)
    @order.total_price = @cart.total_price
    if @order.save
      @cart.cart_items.destroy_all
      redirect_to order_path(@order), notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def order_params
    params.require(:order).permit(:total_price)
  end
end

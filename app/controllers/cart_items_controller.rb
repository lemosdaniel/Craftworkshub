class CartItemsController < ApplicationController
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])

    @cart_item = @cart.cart_items.find_or_initialize_by(product: product)

    if @cart_item.new_record?
      @cart_item.quantity = 1
    else
      @cart_item.quantity += 1
    end

    if @cart_item.save
      redirect_to cart_path(@cart), notice: 'Item added to cart.'
    else
      redirect_to products_path, alert: 'Unable to add item to cart.'
    end
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])

    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Cart updated.'
    else
      redirect_to cart_path, alert: 'Unable to update cart.'
    end
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

end

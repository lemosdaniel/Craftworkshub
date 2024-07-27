class CheckoutsController < ApplicationController

  include ApplicationHelper
  def show
    @cart = current_user.cart
  end

  def create
    @cart = current_user.cart
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: @cart.cart_items.map { |item| 
        {
          price_data: {
            currency: 'usd',
            product_data: {
              name: item.product.title,
            },
            unit_amount: (item.product.price * 100).to_i, # Stripe amount in cents
          },
          quantity: item.quantity,
        }
      },
      mode: 'payment',
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
    })
    respond_to do |format|
      format.html { redirect_to @session.url, allow_other_host: true }
      format.turbo_stream { render turbo_stream: turbo_stream.replace('checkout-form', partial: 'checkouts/redirect', locals: { session: @session }) }
    end
  end

  def success
    @cart = current_user.cart
    order = Order.create(user: current_user, total_price: @cart.total_price)

    @cart.cart_items.each do |cart_item|
      OrderItem.create(
        order: order,
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )

      product_title = cart_item.product.title
      user_name = current_user.name
      message = "🎉 #{user_name} has placed an order for your product '#{product_title}' with a quantity of #{cart_item.quantity}."
      create_event_and_notification(cart_item.product.user, message)
    end

    @cart.cart_items.destroy_all # Empty the cart
    redirect_to order_path(order), notice: 'Your order has been placed successfully.'
  end

  def cancel
    # Handle cancelled payment here
  end
end

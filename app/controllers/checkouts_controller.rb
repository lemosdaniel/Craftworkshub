class CheckoutsController < ApplicationController
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
  end

  def cancel
    # Handle cancelled payment here
  end
end

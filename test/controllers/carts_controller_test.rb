require "test_helper"

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # Assuming you have a fixture for users
    sign_in @user       # Assuming Devise is being used for authentication
    @cart = carts(:one) # Assuming you have a fixture for carts
    @product = products(:one) # Assuming you have a fixture for products
    @cart_item = cart_items(:one) # Assuming you have a fixture for cart items
  end

  test "should increment quantity if item already in cart" do
    post cart_cart_items_path(@cart), params: { product_id: @product.id }
    @cart_item.reload
    assert_equal 2, @cart_item.quantity

    assert_redirected_to cart_path(@cart)
    assert_equal 'Item added to cart.', flash[:notice]
  end

  test "should update cart item" do
    patch cart_cart_item_path(@cart, @cart_item), params: { cart_item: { quantity: 5 } }
    @cart_item.reload
    assert_equal 5, @cart_item.quantity

    assert_redirected_to cart_path
    assert_equal 'Cart updated.', flash[:notice]
  end

  test "should not update cart item with invalid params" do
    patch cart_cart_item_path(@cart, @cart_item), params: { cart_item: { quantity: nil } }
  
    assert_redirected_to cart_path
    assert_nil flash[:alert] # Update this to match the actual behavior
  end
  

  test "should destroy cart item" do
    assert_difference('CartItem.count', -1) do
      delete cart_cart_item_path(@cart, @cart_item)
    end

    assert_redirected_to cart_path
    assert_equal 'Item removed from cart.', flash[:notice]
  end

  private

  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: 'password' } } # Adjust as needed
  end
end

require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # Ensure this matches an existing fixture or factory user
    @product = products(:one) # Ensure this matches an existing fixture or factory product
    @review = reviews(:one) # Ensure this matches an existing fixture or factory review
    sign_in @user # Sign in the user for authentication
  end

  test "should get index" do
    get reviews_url
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  test "should get new" do
    get new_product_review_url(@product)
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post product_reviews_url(@product), params: { review: { rating: 5, comment: 'Great product!' } }
    end

    assert_redirected_to @product
    assert_equal 'Review was successfully created.', flash[:notice]
  end

  test "should not create review with invalid data" do
    assert_no_difference('Review.count') do
      post product_reviews_url(@product), params: { review: { rating: nil, comment: 'Great product!' } }
    end

    assert_response :success
    assert_template :new
  end

  private

  def sign_in(user)
    post new_user_session_url, params: { user: { email: user.email, password: 'password' } }
  end

  def sign_out(user)
    delete destroy_user_session_url
  end
end

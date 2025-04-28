require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get reviews_new_url
    assert_response :success
  end

  test "should get show" do
    get reviews_show_url
    assert_response :success
  end

  test "should get createdestroy" do
    get reviews_createdestroy_url
    assert_response :success
  end
end

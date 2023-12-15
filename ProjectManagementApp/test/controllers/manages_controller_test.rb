require "test_helper"

class ManagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:user_one)
  end

  test "should get index" do
    get manages_url
    assert_response :success
  end

end

require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:user_one)
  end

  test "should get index" do
    get assignments_url
    assert_response :success
  end

end

require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:user_one)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

end

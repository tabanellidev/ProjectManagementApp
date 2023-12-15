require "test_helper"


class ProjectsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in users(:user_one)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

end

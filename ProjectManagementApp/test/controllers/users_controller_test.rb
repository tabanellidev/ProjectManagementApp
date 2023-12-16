require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "Not logged" do
    get projects_url
    assert_response :redirect
  end

end

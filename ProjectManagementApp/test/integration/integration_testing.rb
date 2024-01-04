require 'test_helper'

  class BrowsingTest < ActionDispatch::IntegrationTest

      test "Login and browse site" do

        # login via https
        https!
        get "/users/sign_in"
        assert_response :success

        sign_in users(:admin)

        get "/projects/"
        assert_response :success

        post projects_path, params: { project: {id: 3, title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2035,1,31)} }
        assert_redirected_to project_path(id: 3)

        put project_path(3), params: { project: {title: "Nuovo titolo"} }
        assert_redirected_to project_path(id: 3)

        get "/tasks/new?project_id=3"
        assert_response :success

        post tasks_path, params: { task: {id: 3, title: "Test", description: "Test", project_id: 3, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2035,1,31)} }
        assert_redirected_to task_path(id: 3)

        put task_path(3), params: { task: {title: "Nuovo titolo"} }
        assert_redirected_to task_path(id: 3)

        post assignments_path, params: { assignment: {id: 1, user_id: 0, task_id: 3, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2035,1,31)} }
        assert_redirected_to assignment_path(id: 1)

        get "/assignments/1/complete"
        assert_redirected_to assignment_path(id: 1)

        assert_equal(Task.find(3).status, 'Completed')
        assert_equal(Project.find(3).status, 'Completed')

      end

  end

require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest

  test "Not logged" do
    get projects_url
    assert_response :redirect
  end

  test "Assignment Junior permissions" do
    sign_in users(:junior)

    #Index
    get assignments_url
    assert_response :success

    #Show
    assignment = Assignment.find(0)
    get assignment_path(assignment.id)
    assert_response :success

    #Edit
    get edit_assignment_path(assignment.id)
    assert_redirected_to :notauthorized

    #Update
    put assignment_path(assignment.id), params: { assignment: {user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #Create
    post assignments_path, params: { assignment: {user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #New
    get new_assignment_path, params: {task_id: 0}
    assert_redirected_to :notauthorized

    #Destroy
    delete assignment_path(assignment.id)
    assert_redirected_to :notauthorized

  end

  test "Assignment Senior permissions" do
    sign_in users(:senior)

    #Index
    get assignments_url
    assert_response :success

    #Show
    assignment = Assignment.find(0)
    get assignment_path(assignment.id)
    assert_response :success

    #Edit
    get edit_assignment_path(assignment.id)
    assert_redirected_to :notauthorized

    #Update
    put assignment_path(assignment.id), params: { assignment: {user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #Create
    post assignments_path, params: { assignment: {user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #New
    get new_assignment_path, params: {task_id: 0}
    assert_redirected_to :notauthorized

    #Destroy
    delete assignment_path(assignment.id)
    assert_redirected_to :notauthorized

  end

  test "Assignment Admin permissions" do
    sign_in users(:admin)

    #Index
    get assignments_url
    assert_response :success

    #Show
    assignment = Assignment.find(0)
    get assignment_path(assignment.id)
    assert_response :success

    #Edit
    get edit_assignment_path(assignment.id)
    assert_response :success

    #Update
    put assignment_path(assignment.id), params: { assignment: {user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to assignment_path(id: 0)

    #Create
    post assignments_path, params: { assignment: {id: 1, user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to assignment_path(id: 1)

    #New
    get new_assignment_path, params: {task_id: 0}
    assert_response :success

    #Destroy
    delete assignment_path(assignment.id)
    assert_redirected_to assignments_url

  end

  test "Assignment Junior Manager permissions" do
    sign_in users(:junior_manager)

    #Index
    get assignments_url
    assert_response :success

    #Show
    assignment = Assignment.find(0)
    get assignment_path(assignment.id)
    assert_response :success

    #Edit
    get edit_assignment_path(assignment.id)
    assert_response :success

    #Update
    put assignment_path(assignment.id), params: { assignment: {user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to assignment_path(id: 0)

    #Create
    post assignments_path, params: { assignment: {id: 1, user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to assignment_path(id: 1)

    #New
    get new_assignment_path, params: {task_id: 0}
    assert_response :success

    #Destroy
    delete assignment_path(assignment.id)
    assert_redirected_to assignments_url

  end

  test "Assignment Senior Manager permissions" do
    sign_in users(:senior_manager)

    #Index
    get assignments_url
    assert_response :success

    #Show
    assignment = Assignment.find(0)
    get assignment_path(assignment.id)
    assert_response :success

    #Edit
    get edit_assignment_path(assignment.id)
    assert_response :success

    #Update
    put assignment_path(assignment.id), params: { assignment: {user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to assignment_path(id: 0)

    #Create
    post assignments_path, params: { assignment: {id: 1, user_id: 0, task_id: 0, title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to assignment_path(id: 1)

    #New
    get new_assignment_path, params: {task_id: 0}
    assert_response :success

    #Destroy
    delete assignment_path(assignment.id)
    assert_redirected_to assignments_url

  end

end

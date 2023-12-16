require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest

  test "Not logged" do
    get projects_url
    assert_response :redirect
  end

  test "Task Junior permissions" do
    sign_in users(:junior)

    #Index
    get tasks_url
    assert_response :success

    #Show
    task = Task.find(0)
    get task_path(task.id)
    assert_response :success

    #Edit
    get edit_task_path(task.id)
    assert_redirected_to :notauthorized

    #Update
    put task_path(task.id), params: { task: {title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #Create
    post tasks_path, params: { task: {title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #New
    get new_task_path, params: { project_id: 0}
    assert_redirected_to :notauthorized

    #Destroy
    delete task_path(task.id)
    assert_redirected_to :notauthorized

  end

  test "Task Senior permissions" do
    sign_in users(:senior)

    #Index
    get tasks_url
    assert_response :success

    #Show
    task = Task.find(0)
    get task_path(task.id)
    assert_response :success

    #Edit - non può modificare un progetto di cui non è manager
    get edit_task_path(task.id)
    assert_redirected_to :notauthorized

    #Update
    put task_path(task.id), params: { task: {title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #Create
    post tasks_path, params: { task: {title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #New
    get new_task_path, params: { project_id: 0}
    assert_redirected_to :notauthorized

    #Destroy
    delete task_path(task.id)
    assert_redirected_to :notauthorized

  end

  test "Task Admin permissions" do
    sign_in users(:admin)

    #Index
    get tasks_url
    assert_response :success

    #Show
    task = Task.find(0)
    get task_path(task.id)
    assert_response :success

    #Edit
    get edit_task_path(task.id)
    assert_response :success

    #Update
    put task_path(task.id), params: { task: {title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to task_path(id: 0)

    #Create
    post tasks_path, params: { task: {id: 3, title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to task_path(id: 3)

    #New
    get new_task_path, params: { project_id: 0}
    assert_response :success

    #Destroy
    delete task_path(2)
    assert_redirected_to tasks_path

  end

  test "Task Junior Manager permissions" do
    sign_in users(:junior_manager)

    #Index
    get tasks_url
    assert_response :success

    #Show
    task = Task.find(0)
    get task_path(task.id)
    assert_response :success

    #Edit - Può modificare un progetto di cui è manager
    get edit_task_path(task.id)
    assert_response :success

    #Update
    put task_path(task.id), params: { task: {title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to task_path(id: 0)

    #Create
    post tasks_path, params: { task: {id: 3, title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to task_path(id: 3)

    #New
    get new_task_path, params: { project_id: 0}
    assert_response :success

    #Destroy
    delete task_path(2)
    assert_redirected_to tasks_path

  end

  test "Task Senior Manager permissions" do
    sign_in users(:senior_manager)

    #Index
    get tasks_url
    assert_response :success

    #Show
    task = Task.find(0)
    get task_path(task.id)
    assert_response :success

    #Edit - Può modificare un progetto di cui è manager
    get edit_task_path(task.id)
    assert_response :success

    #Update
    put task_path(task.id), params: { task: {title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to task_path(id: 0)

    #Create
    post tasks_path, params: { task: {id:3, title: "Test", description: "Test", project_id: 0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to task_path(id: 3)

    #New
    get new_task_path, params: { project_id: 0}
    assert_response :success

    #Destroy
    delete task_path(2)
    assert_redirected_to tasks_path

  end

end

require "test_helper"


class ProjectsControllerTest < ActionDispatch::IntegrationTest

  test "Not logged" do
    get projects_url
    assert_response :redirect
  end

  test "Project Junior permissions" do
    sign_in users(:junior)

    #Index
    get projects_url
    assert_response :success

    #Show
    project = Project.find(0)
    get project_path(project.id)
    assert_response :success

    #Edit
    get edit_project_path(project.id)
    assert_redirected_to :notauthorized

    #Update
    put project_path(project.id), params: { project: {title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #Create
    post projects_path, params: { project: {title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #New
    get new_project_path
    assert_redirected_to :notauthorized

    #Destroy
    delete project_path(project.id)
    assert_redirected_to :notauthorized

  end

  test "Project Senior permissions" do
    sign_in users(:senior)

    #Index
    get projects_url
    assert_response :success

    #Show
    project = Project.find(0)
    get project_path(project.id)
    assert_response :success

    #Edit - non può modificare un progetto di cui non è manager
    get edit_project_path(project.id)
    assert_redirected_to :notauthorized

    #Update
    put project_path(project.id), params: { project: {title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #Create
    post projects_path, params: { project: {id: 3, title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to project_path(id: 3)

    #New
    get new_project_path
    assert_response :success

    #Destroy
    project = Project.find(1)
    delete project_path(project.id)
    assert_redirected_to :notauthorized

  end

  test "Project Admin permissions" do
    sign_in users(:admin)

    #Index
    get projects_url
    assert_response :success

    #Show
    project = Project.find(0)
    get project_path(project.id)
    assert_response :success

    #Edit
    get edit_project_path(project.id)
    assert_response :success

    #Update
    put project_path(project.id), params: { project: {title: "Test", client: "Cliente1", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to project_path(id: 0)

    #Create
    post projects_path, params: { project: {id: 3, title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to project_path(id: 3)

    #New
    get new_project_path
    assert_response :success

    #Destroy
    project = Project.find(2)
    delete project_path(project.id)
    assert_redirected_to projects_path

  end

  test "Project Junior Manager permissions" do
    sign_in users(:junior_manager)

    #Index
    get projects_url
    assert_response :success

    #Show
    project = Project.find(0)
    get project_path(project.id)
    assert_response :success

    #Edit - Può modificare un progetto di cui è manager
    get edit_project_path(project.id)
    assert_response :success

    #Update
    put project_path(project.id), params: { project: {title: "Test", description: "Test", client: "Cliente1",start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to project_path(id: 0)

    #Create
    post projects_path, params: { project: {title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to :notauthorized

    #New
    get new_project_path
    assert_redirected_to :notauthorized

    #Destroy
    delete project_path(project.id)
    assert_redirected_to :notauthorized

  end

  test "Project Senior Manager permissions" do
    sign_in users(:senior_manager)

    #Index
    get projects_url
    assert_response :success

    #Show
    project = Project.find(0)
    get project_path(project.id)
    assert_response :success

    #Edit - Può modificare un progetto di cui è manager
    get edit_project_path(project.id)
    assert_response :success

    #Update
    put project_path(project.id), params: { project: {title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to project_path(id: 0)

    #Create
    post projects_path, params: { project: {id: 3, title: "Test", description: "Test", client: "Cliente1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31)} }
    assert_redirected_to project_path(id: 3)

    #New
    get new_project_path
    assert_response :success

    #Destroy
    project = Project.find(1)
    delete project_path(project.id)
    assert_redirected_to :notauthorized

  end

end

require "test_helper"

class ManagesControllerTest < ActionDispatch::IntegrationTest

  test "Not logged" do
    get projects_url
    assert_response :redirect
  end

  test "Manage Junior permissions" do
    sign_in users(:junior)

    #Index
    get manages_url
    assert_response :success

    #Show
    manage = Manage.find(0)
    get manage_path(manage.id)
    assert_response :success

    #Edit
    get edit_manage_path(manage.id)
    assert_redirected_to :notauthorized

    #Update
    put manage_path(manage.id), params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to :notauthorized

    #Create
    post manages_path, params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to :notauthorized

    #New
    get new_manage_path, params: {project_id: 0}
    assert_redirected_to :notauthorized

    #Destroy
    delete manage_path(manage.id)
    assert_redirected_to :notauthorized

  end

  test "Manage Senior permissions" do
    sign_in users(:senior)

    #Index
    get manages_url
    assert_response :success

    #Show
    manage = Manage.find(0)
    get manage_path(manage.id)
    assert_response :success

    #Edit
    get edit_manage_path(manage.id)
    assert_redirected_to :notauthorized

    #Update
    put manage_path(manage.id), params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to :notauthorized

    #Create
    post manages_path, params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to :notauthorized

    #New
    get new_manage_path, params: {project_id: 0}
    assert_redirected_to :notauthorized

    #Destroy
    delete manage_path(manage.id)
    assert_redirected_to :notauthorized

  end

  test "Manage Admin permissions" do
    sign_in users(:admin)

    #Index
    get manages_url
    assert_response :success

    #Show
    manage = Manage.find(0)
    get manage_path(manage.id)
    assert_response :success

    #Edit
    get edit_manage_path(manage.id)
    assert_response :success

    #Update
    put manage_path(manage.id), params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to manage_path(id: 0)

    #Create
    post manages_path, params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to manage_path(id: 3)

    #New
    get new_manage_path, params: {project_id: 0}
    assert_response :success

    #Destroy
    delete manage_path(manage.id)
    assert_redirected_to manages_url
  end

  test "Manage Junior Manager permissions" do
    sign_in users(:junior_manager)

    #Index
    get manages_url
    assert_response :success

    #Show
    manage = Manage.find(0)
    get manage_path(manage.id)
    assert_response :success

    #Edit
    get edit_manage_path(manage.id)
    assert_redirected_to :notauthorized

    #Update
    put manage_path(manage.id), params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to :notauthorized

    #Create
    post manages_path, params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to :notauthorized

    #New
    get new_manage_path, params: {project_id: 0}
    assert_redirected_to :notauthorized

    #Destroy
    delete manage_path(manage.id)
    assert_redirected_to :notauthorized

  end


  test "Manage Senior Manager permissions" do
    sign_in users(:senior_manager)

    #Index
    get manages_url
    assert_response :success

    #Show
    manage = Manage.find(2)
    get manage_path(manage.id)
    assert_response :success


    #Edit
    get edit_manage_path(manage.id)
    assert_response :success

    #Update
    put manage_path(manage.id), params: { manage: {user_id: 0} }
    assert_redirected_to manage_path(id: 2)

    #Destroy
    delete manage_path(id: 2)
    assert_redirected_to manages_url

    #New
    get new_manage_path, params: { project_id: 0 }
    assert_response :success

    #Create
    post manages_path, params: { manage: {user_id: 0, project_id: 0} }
    assert_redirected_to manage_path(id: 2)

  end

end

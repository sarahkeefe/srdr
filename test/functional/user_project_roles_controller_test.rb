require 'test_helper'

class UserProjectRolesControllerTest < ActionController::TestCase
  setup do
    @user_project_role = user_project_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_project_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_project_role" do
    assert_difference('UserProjectRole.count') do
      post :create, :user_project_role => @user_project_role.attributes
    end

    assert_redirected_to user_project_role_path(assigns(:user_project_role))
  end

  test "should show user_project_role" do
    get :show, :id => @user_project_role.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user_project_role.to_param
    assert_response :success
  end

  test "should update user_project_role" do
    put :update, :id => @user_project_role.to_param, :user_project_role => @user_project_role.attributes
    assert_redirected_to user_project_role_path(assigns(:user_project_role))
  end

  test "should destroy user_project_role" do
    assert_difference('UserProjectRole.count', -1) do
      delete :destroy, :id => @user_project_role.to_param
    end

    assert_redirected_to user_project_roles_path
  end
end

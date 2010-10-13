require 'test_helper'

class ArmsControllerTest < ActionController::TestCase
  setup do
    @arm = arms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create arm" do
    assert_difference('Arm.count') do
      post :create, :arm => @arm.attributes
    end

    assert_redirected_to arm_path(assigns(:arm))
  end

  test "should show arm" do
    get :show, :id => @arm.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @arm.to_param
    assert_response :success
  end

  test "should update arm" do
    put :update, :id => @arm.to_param, :arm => @arm.attributes
    assert_redirected_to arm_path(assigns(:arm))
  end

  test "should destroy arm" do
    assert_difference('Arm.count', -1) do
      delete :destroy, :id => @arm.to_param
    end

    assert_redirected_to arms_path
  end
end

require 'test_helper'

class AdverseEventArmsControllerTest < ActionController::TestCase
  setup do
    @adverse_event_arm = adverse_event_arms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adverse_event_arms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adverse_event_arm" do
    assert_difference('AdverseEventArm.count') do
      post :create, :adverse_event_arm => @adverse_event_arm.attributes
    end

    assert_redirected_to adverse_event_arm_path(assigns(:adverse_event_arm))
  end

  test "should show adverse_event_arm" do
    get :show, :id => @adverse_event_arm.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @adverse_event_arm.to_param
    assert_response :success
  end

  test "should update adverse_event_arm" do
    put :update, :id => @adverse_event_arm.to_param, :adverse_event_arm => @adverse_event_arm.attributes
    assert_redirected_to adverse_event_arm_path(assigns(:adverse_event_arm))
  end

  test "should destroy adverse_event_arm" do
    assert_difference('AdverseEventArm.count', -1) do
      delete :destroy, :id => @adverse_event_arm.to_param
    end

    assert_redirected_to adverse_event_arms_path
  end
end

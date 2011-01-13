require 'test_helper'

class AdverseEventResultsControllerTest < ActionController::TestCase
  setup do
    @adverse_event_result = adverse_event_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adverse_event_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adverse_event_result" do
    assert_difference('AdverseEventResult.count') do
      post :create, :adverse_event_result => @adverse_event_result.attributes
    end

    assert_redirected_to adverse_event_result_path(assigns(:adverse_event_result))
  end

  test "should show adverse_event_result" do
    get :show, :id => @adverse_event_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @adverse_event_result.to_param
    assert_response :success
  end

  test "should update adverse_event_result" do
    put :update, :id => @adverse_event_result.to_param, :adverse_event_result => @adverse_event_result.attributes
    assert_redirected_to adverse_event_result_path(assigns(:adverse_event_result))
  end

  test "should destroy adverse_event_result" do
    assert_difference('AdverseEventResult.count', -1) do
      delete :destroy, :id => @adverse_event_result.to_param
    end

    assert_redirected_to adverse_event_results_path
  end
end

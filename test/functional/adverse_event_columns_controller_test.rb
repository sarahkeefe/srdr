require 'test_helper'

class AdverseEventColumnsControllerTest < ActionController::TestCase
  setup do
    @adverse_event_column = adverse_event_columns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adverse_event_columns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adverse_event_column" do
    assert_difference('AdverseEventColumn.count') do
      post :create, :adverse_event_column => @adverse_event_column.attributes
    end

    assert_redirected_to adverse_event_column_path(assigns(:adverse_event_column))
  end

  test "should show adverse_event_column" do
    get :show, :id => @adverse_event_column.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @adverse_event_column.to_param
    assert_response :success
  end

  test "should update adverse_event_column" do
    put :update, :id => @adverse_event_column.to_param, :adverse_event_column => @adverse_event_column.attributes
    assert_redirected_to adverse_event_column_path(assigns(:adverse_event_column))
  end

  test "should destroy adverse_event_column" do
    assert_difference('AdverseEventColumn.count', -1) do
      delete :destroy, :id => @adverse_event_column.to_param
    end

    assert_redirected_to adverse_event_columns_path
  end
end

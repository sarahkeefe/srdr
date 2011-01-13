require 'test_helper'

class DefaultAdverseEventColumnsControllerTest < ActionController::TestCase
  setup do
    @default_adverse_event_column = default_adverse_event_columns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:default_adverse_event_columns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create default_adverse_event_column" do
    assert_difference('DefaultAdverseEventColumn.count') do
      post :create, :default_adverse_event_column => @default_adverse_event_column.attributes
    end

    assert_redirected_to default_adverse_event_column_path(assigns(:default_adverse_event_column))
  end

  test "should show default_adverse_event_column" do
    get :show, :id => @default_adverse_event_column.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @default_adverse_event_column.to_param
    assert_response :success
  end

  test "should update default_adverse_event_column" do
    put :update, :id => @default_adverse_event_column.to_param, :default_adverse_event_column => @default_adverse_event_column.attributes
    assert_redirected_to default_adverse_event_column_path(assigns(:default_adverse_event_column))
  end

  test "should destroy default_adverse_event_column" do
    assert_difference('DefaultAdverseEventColumn.count', -1) do
      delete :destroy, :id => @default_adverse_event_column.to_param
    end

    assert_redirected_to default_adverse_event_columns_path
  end
end

require 'test_helper'

class OutcomeColumnsControllerTest < ActionController::TestCase
  setup do
    @outcome_column = outcome_columns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_columns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_column" do
    assert_difference('OutcomeColumn.count') do
      post :create, :outcome_column => @outcome_column.attributes
    end

    assert_redirected_to outcome_column_path(assigns(:outcome_column))
  end

  test "should show outcome_column" do
    get :show, :id => @outcome_column.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_column.to_param
    assert_response :success
  end

  test "should update outcome_column" do
    put :update, :id => @outcome_column.to_param, :outcome_column => @outcome_column.attributes
    assert_redirected_to outcome_column_path(assigns(:outcome_column))
  end

  test "should destroy outcome_column" do
    assert_difference('OutcomeColumn.count', -1) do
      delete :destroy, :id => @outcome_column.to_param
    end

    assert_redirected_to outcome_columns_path
  end
end

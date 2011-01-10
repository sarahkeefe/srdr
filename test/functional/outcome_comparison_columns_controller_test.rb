require 'test_helper'

class OutcomeComparisonColumnsControllerTest < ActionController::TestCase
  setup do
    @outcome_comparison_column = outcome_comparison_columns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_comparison_columns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_comparison_column" do
    assert_difference('OutcomeComparisonColumn.count') do
      post :create, :outcome_comparison_column => @outcome_comparison_column.attributes
    end

    assert_redirected_to outcome_comparison_column_path(assigns(:outcome_comparison_column))
  end

  test "should show outcome_comparison_column" do
    get :show, :id => @outcome_comparison_column.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_comparison_column.to_param
    assert_response :success
  end

  test "should update outcome_comparison_column" do
    put :update, :id => @outcome_comparison_column.to_param, :outcome_comparison_column => @outcome_comparison_column.attributes
    assert_redirected_to outcome_comparison_column_path(assigns(:outcome_comparison_column))
  end

  test "should destroy outcome_comparison_column" do
    assert_difference('OutcomeComparisonColumn.count', -1) do
      delete :destroy, :id => @outcome_comparison_column.to_param
    end

    assert_redirected_to outcome_comparison_columns_path
  end
end

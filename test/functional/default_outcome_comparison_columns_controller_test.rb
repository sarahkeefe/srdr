require 'test_helper'

class DefaultOutcomeComparisonColumnsControllerTest < ActionController::TestCase
  setup do
    @default_outcome_comparison_column = default_outcome_comparison_columns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:default_outcome_comparison_columns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create default_outcome_comparison_column" do
    assert_difference('DefaultOutcomeComparisonColumn.count') do
      post :create, :default_outcome_comparison_column => @default_outcome_comparison_column.attributes
    end

    assert_redirected_to default_outcome_comparison_column_path(assigns(:default_outcome_comparison_column))
  end

  test "should show default_outcome_comparison_column" do
    get :show, :id => @default_outcome_comparison_column.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @default_outcome_comparison_column.to_param
    assert_response :success
  end

  test "should update default_outcome_comparison_column" do
    put :update, :id => @default_outcome_comparison_column.to_param, :default_outcome_comparison_column => @default_outcome_comparison_column.attributes
    assert_redirected_to default_outcome_comparison_column_path(assigns(:default_outcome_comparison_column))
  end

  test "should destroy default_outcome_comparison_column" do
    assert_difference('DefaultOutcomeComparisonColumn.count', -1) do
      delete :destroy, :id => @default_outcome_comparison_column.to_param
    end

    assert_redirected_to default_outcome_comparison_columns_path
  end
end

require 'test_helper'

class OutcomeColumnValuesControllerTest < ActionController::TestCase
  setup do
    @outcome_column_value = outcome_column_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_column_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_column_value" do
    assert_difference('OutcomeColumnValue.count') do
      post :create, :outcome_column_value => @outcome_column_value.attributes
    end

    assert_redirected_to outcome_column_value_path(assigns(:outcome_column_value))
  end

  test "should show outcome_column_value" do
    get :show, :id => @outcome_column_value.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_column_value.to_param
    assert_response :success
  end

  test "should update outcome_column_value" do
    put :update, :id => @outcome_column_value.to_param, :outcome_column_value => @outcome_column_value.attributes
    assert_redirected_to outcome_column_value_path(assigns(:outcome_column_value))
  end

  test "should destroy outcome_column_value" do
    assert_difference('OutcomeColumnValue.count', -1) do
      delete :destroy, :id => @outcome_column_value.to_param
    end

    assert_redirected_to outcome_column_values_path
  end
end

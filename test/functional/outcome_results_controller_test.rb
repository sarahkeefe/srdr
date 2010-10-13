require 'test_helper'

class OutcomeResultsControllerTest < ActionController::TestCase
  setup do
    @outcome_result = outcome_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_result" do
    assert_difference('OutcomeResult.count') do
      post :create, :outcome_result => @outcome_result.attributes
    end

    assert_redirected_to outcome_result_path(assigns(:outcome_result))
  end

  test "should show outcome_result" do
    get :show, :id => @outcome_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_result.to_param
    assert_response :success
  end

  test "should update outcome_result" do
    put :update, :id => @outcome_result.to_param, :outcome_result => @outcome_result.attributes
    assert_redirected_to outcome_result_path(assigns(:outcome_result))
  end

  test "should destroy outcome_result" do
    assert_difference('OutcomeResult.count', -1) do
      delete :destroy, :id => @outcome_result.to_param
    end

    assert_redirected_to outcome_results_path
  end
end

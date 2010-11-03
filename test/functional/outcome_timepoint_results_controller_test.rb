require 'test_helper'

class OutcomeTimepointResultsControllerTest < ActionController::TestCase
  setup do
    @outcome_timepoint_result = outcome_timepoint_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_timepoint_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_timepoint_result" do
    assert_difference('OutcomeTimepointResult.count') do
      post :create, :outcome_timepoint_result => @outcome_timepoint_result.attributes
    end

    assert_redirected_to outcome_timepoint_result_path(assigns(:outcome_timepoint_result))
  end

  test "should show outcome_timepoint_result" do
    get :show, :id => @outcome_timepoint_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_timepoint_result.to_param
    assert_response :success
  end

  test "should update outcome_timepoint_result" do
    put :update, :id => @outcome_timepoint_result.to_param, :outcome_timepoint_result => @outcome_timepoint_result.attributes
    assert_redirected_to outcome_timepoint_result_path(assigns(:outcome_timepoint_result))
  end

  test "should destroy outcome_timepoint_result" do
    assert_difference('OutcomeTimepointResult.count', -1) do
      delete :destroy, :id => @outcome_timepoint_result.to_param
    end

    assert_redirected_to outcome_timepoint_results_path
  end
end

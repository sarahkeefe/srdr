require 'test_helper'

class OutcomeTimepointsControllerTest < ActionController::TestCase
  setup do
    @outcome_timepoint = outcome_timepoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_timepoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_timepoint" do
    assert_difference('OutcomeTimepoint.count') do
      post :create, :outcome_timepoint => @outcome_timepoint.attributes
    end

    assert_redirected_to outcome_timepoint_path(assigns(:outcome_timepoint))
  end

  test "should show outcome_timepoint" do
    get :show, :id => @outcome_timepoint.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_timepoint.to_param
    assert_response :success
  end

  test "should update outcome_timepoint" do
    put :update, :id => @outcome_timepoint.to_param, :outcome_timepoint => @outcome_timepoint.attributes
    assert_redirected_to outcome_timepoint_path(assigns(:outcome_timepoint))
  end

  test "should destroy outcome_timepoint" do
    assert_difference('OutcomeTimepoint.count', -1) do
      delete :destroy, :id => @outcome_timepoint.to_param
    end

    assert_redirected_to outcome_timepoints_path
  end
end

require 'test_helper'

class OutcomeAnalysesControllerTest < ActionController::TestCase
  setup do
    @outcome_analyasis = outcome_analyses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_analyses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_analyasis" do
    assert_difference('OutcomeAnalysis.count') do
      post :create, :outcome_analyasis => @outcome_analyasis.attributes
    end

    assert_redirected_to outcome_analyasis_path(assigns(:outcome_analyasis))
  end

  test "should show outcome_analyasis" do
    get :show, :id => @outcome_analyasis.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_analyasis.to_param
    assert_response :success
  end

  test "should update outcome_analyasis" do
    put :update, :id => @outcome_analyasis.to_param, :outcome_analyasis => @outcome_analyasis.attributes
    assert_redirected_to outcome_analyasis_path(assigns(:outcome_analyasis))
  end

  test "should destroy outcome_analyasis" do
    assert_difference('OutcomeAnalysis.count', -1) do
      delete :destroy, :id => @outcome_analyasis.to_param
    end

    assert_redirected_to outcome_analyses_path
  end
end

require 'test_helper'

class OutcomeAnalysesControllerTest < ActionController::TestCase
  setup do
    @outcome_analysis = outcome_analyses(:one)
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

  test "should create outcome_analysis" do
    assert_difference('OutcomeAnalysis.count') do
      post :create, :outcome_analysis => @outcome_analysis.attributes
    end

    assert_redirected_to outcome_analysis_path(assigns(:outcome_analysis))
  end

  test "should show outcome_analysis" do
    get :show, :id => @outcome_analysis.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_analysis.to_param
    assert_response :success
  end

  test "should update outcome_analysis" do
    put :update, :id => @outcome_analysis.to_param, :outcome_analysis => @outcome_analysis.attributes
    assert_redirected_to outcome_analysis_path(assigns(:outcome_analysis))
  end

  test "should destroy outcome_analysis" do
    assert_difference('OutcomeAnalysis.count', -1) do
      delete :destroy, :id => @outcome_analysis.to_param
    end

    assert_redirected_to outcome_analyses_path
  end
end

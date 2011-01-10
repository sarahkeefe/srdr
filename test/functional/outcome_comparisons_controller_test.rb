require 'test_helper'

class OutcomeComparisonsControllerTest < ActionController::TestCase
  setup do
    @outcome_comparison = outcome_comparisons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_comparisons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_comparison" do
    assert_difference('OutcomeComparison.count') do
      post :create, :outcome_comparison => @outcome_comparison.attributes
    end

    assert_redirected_to outcome_comparison_path(assigns(:outcome_comparison))
  end

  test "should show outcome_comparison" do
    get :show, :id => @outcome_comparison.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_comparison.to_param
    assert_response :success
  end

  test "should update outcome_comparison" do
    put :update, :id => @outcome_comparison.to_param, :outcome_comparison => @outcome_comparison.attributes
    assert_redirected_to outcome_comparison_path(assigns(:outcome_comparison))
  end

  test "should destroy outcome_comparison" do
    assert_difference('OutcomeComparison.count', -1) do
      delete :destroy, :id => @outcome_comparison.to_param
    end

    assert_redirected_to outcome_comparisons_path
  end
end

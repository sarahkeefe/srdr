require 'test_helper'

class OutcomeSubgroupsControllerTest < ActionController::TestCase
  setup do
    @outcome_subgroup = outcome_subgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_subgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_subgroup" do
    assert_difference('OutcomeSubgroup.count') do
      post :create, :outcome_subgroup => @outcome_subgroup.attributes
    end

    assert_redirected_to outcome_subgroup_path(assigns(:outcome_subgroup))
  end

  test "should show outcome_subgroup" do
    get :show, :id => @outcome_subgroup.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_subgroup.to_param
    assert_response :success
  end

  test "should update outcome_subgroup" do
    put :update, :id => @outcome_subgroup.to_param, :outcome_subgroup => @outcome_subgroup.attributes
    assert_redirected_to outcome_subgroup_path(assigns(:outcome_subgroup))
  end

  test "should destroy outcome_subgroup" do
    assert_difference('OutcomeSubgroup.count', -1) do
      delete :destroy, :id => @outcome_subgroup.to_param
    end

    assert_redirected_to outcome_subgroups_path
  end
end

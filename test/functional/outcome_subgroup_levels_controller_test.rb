require 'test_helper'

class OutcomeSubgroupLevelsControllerTest < ActionController::TestCase
  setup do
    @outcome_subgroup_level = outcome_subgroup_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_subgroup_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_subgroup_level" do
    assert_difference('OutcomeSubgroupLevel.count') do
      post :create, :outcome_subgroup_level => @outcome_subgroup_level.attributes
    end

    assert_redirected_to outcome_subgroup_level_path(assigns(:outcome_subgroup_level))
  end

  test "should show outcome_subgroup_level" do
    get :show, :id => @outcome_subgroup_level.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_subgroup_level.to_param
    assert_response :success
  end

  test "should update outcome_subgroup_level" do
    put :update, :id => @outcome_subgroup_level.to_param, :outcome_subgroup_level => @outcome_subgroup_level.attributes
    assert_redirected_to outcome_subgroup_level_path(assigns(:outcome_subgroup_level))
  end

  test "should destroy outcome_subgroup_level" do
    assert_difference('OutcomeSubgroupLevel.count', -1) do
      delete :destroy, :id => @outcome_subgroup_level.to_param
    end

    assert_redirected_to outcome_subgroup_levels_path
  end
end

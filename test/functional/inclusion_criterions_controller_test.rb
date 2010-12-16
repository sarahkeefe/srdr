require 'test_helper'

class InclusionCriterionsControllerTest < ActionController::TestCase
  setup do
    @inclusion_criterion = inclusion_criterions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inclusion_criterions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inclusion_criterion" do
    assert_difference('InclusionCriterion.count') do
      post :create, :inclusion_criterion => @inclusion_criterion.attributes
    end

    assert_redirected_to inclusion_criterion_path(assigns(:inclusion_criterion))
  end

  test "should show inclusion_criterion" do
    get :show, :id => @inclusion_criterion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @inclusion_criterion.to_param
    assert_response :success
  end

  test "should update inclusion_criterion" do
    put :update, :id => @inclusion_criterion.to_param, :inclusion_criterion => @inclusion_criterion.attributes
    assert_redirected_to inclusion_criterion_path(assigns(:inclusion_criterion))
  end

  test "should destroy inclusion_criterion" do
    assert_difference('InclusionCriterion.count', -1) do
      delete :destroy, :id => @inclusion_criterion.to_param
    end

    assert_redirected_to inclusion_criterions_path
  end
end

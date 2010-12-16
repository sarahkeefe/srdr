require 'test_helper'

class InclusionCriteriasControllerTest < ActionController::TestCase
  setup do
    @inclusion_criteria = inclusion_criterias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inclusion_criterias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inclusion_criteria" do
    assert_difference('InclusionCriteria.count') do
      post :create, :inclusion_criteria => @inclusion_criteria.attributes
    end

    assert_redirected_to inclusion_criteria_path(assigns(:inclusion_criteria))
  end

  test "should show inclusion_criteria" do
    get :show, :id => @inclusion_criteria.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @inclusion_criteria.to_param
    assert_response :success
  end

  test "should update inclusion_criteria" do
    put :update, :id => @inclusion_criteria.to_param, :inclusion_criteria => @inclusion_criteria.attributes
    assert_redirected_to inclusion_criteria_path(assigns(:inclusion_criteria))
  end

  test "should destroy inclusion_criteria" do
    assert_difference('InclusionCriteria.count', -1) do
      delete :destroy, :id => @inclusion_criteria.to_param
    end

    assert_redirected_to inclusion_criterias_path
  end
end

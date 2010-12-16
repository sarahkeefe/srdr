require 'test_helper'

class InclusionCriteriaItemsControllerTest < ActionController::TestCase
  setup do
    @inclusion_criteria_item = inclusion_criteria_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inclusion_criteria_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inclusion_criteria_item" do
    assert_difference('InclusionCriteriaItem.count') do
      post :create, :inclusion_criteria_item => @inclusion_criteria_item.attributes
    end

    assert_redirected_to inclusion_criteria_item_path(assigns(:inclusion_criteria_item))
  end

  test "should show inclusion_criteria_item" do
    get :show, :id => @inclusion_criteria_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @inclusion_criteria_item.to_param
    assert_response :success
  end

  test "should update inclusion_criteria_item" do
    put :update, :id => @inclusion_criteria_item.to_param, :inclusion_criteria_item => @inclusion_criteria_item.attributes
    assert_redirected_to inclusion_criteria_item_path(assigns(:inclusion_criteria_item))
  end

  test "should destroy inclusion_criteria_item" do
    assert_difference('InclusionCriteriaItem.count', -1) do
      delete :destroy, :id => @inclusion_criteria_item.to_param
    end

    assert_redirected_to inclusion_criteria_items_path
  end
end

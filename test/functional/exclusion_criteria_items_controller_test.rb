require 'test_helper'

class ExclusionCriteriaItemsControllerTest < ActionController::TestCase
  setup do
    @exclusion_criteria_item = exclusion_criteria_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exclusion_criteria_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exclusion_criteria_item" do
    assert_difference('ExclusionCriteriaItem.count') do
      post :create, :exclusion_criteria_item => @exclusion_criteria_item.attributes
    end

    assert_redirected_to exclusion_criteria_item_path(assigns(:exclusion_criteria_item))
  end

  test "should show exclusion_criteria_item" do
    get :show, :id => @exclusion_criteria_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @exclusion_criteria_item.to_param
    assert_response :success
  end

  test "should update exclusion_criteria_item" do
    put :update, :id => @exclusion_criteria_item.to_param, :exclusion_criteria_item => @exclusion_criteria_item.attributes
    assert_redirected_to exclusion_criteria_item_path(assigns(:exclusion_criteria_item))
  end

  test "should destroy exclusion_criteria_item" do
    assert_difference('ExclusionCriteriaItem.count', -1) do
      delete :destroy, :id => @exclusion_criteria_item.to_param
    end

    assert_redirected_to exclusion_criteria_items_path
  end
end

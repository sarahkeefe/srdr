require 'test_helper'

class PopulationCharacteristicSubcategoriesControllerTest < ActionController::TestCase
  setup do
    @population_characteristic_subcategory = population_characteristic_subcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:population_characteristic_subcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create population_characteristic_subcategory" do
    assert_difference('PopulationCharacteristicSubcategory.count') do
      post :create, :population_characteristic_subcategory => @population_characteristic_subcategory.attributes
    end

    assert_redirected_to population_characteristic_subcategory_path(assigns(:population_characteristic_subcategory))
  end

  test "should show population_characteristic_subcategory" do
    get :show, :id => @population_characteristic_subcategory.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @population_characteristic_subcategory.to_param
    assert_response :success
  end

  test "should update population_characteristic_subcategory" do
    put :update, :id => @population_characteristic_subcategory.to_param, :population_characteristic_subcategory => @population_characteristic_subcategory.attributes
    assert_redirected_to population_characteristic_subcategory_path(assigns(:population_characteristic_subcategory))
  end

  test "should destroy population_characteristic_subcategory" do
    assert_difference('PopulationCharacteristicSubcategory.count', -1) do
      delete :destroy, :id => @population_characteristic_subcategory.to_param
    end

    assert_redirected_to population_characteristic_subcategories_path
  end
end

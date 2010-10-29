require 'test_helper'

class PopulationCharacteristicDataPointsControllerTest < ActionController::TestCase
  setup do
    @population_characteristic_data_point = population_characteristic_data_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:population_characteristic_data_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create population_characteristic_data_point" do
    assert_difference('PopulationCharacteristicDataPoint.count') do
      post :create, :population_characteristic_data_point => @population_characteristic_data_point.attributes
    end

    assert_redirected_to population_characteristic_data_point_path(assigns(:population_characteristic_data_point))
  end

  test "should show population_characteristic_data_point" do
    get :show, :id => @population_characteristic_data_point.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @population_characteristic_data_point.to_param
    assert_response :success
  end

  test "should update population_characteristic_data_point" do
    put :update, :id => @population_characteristic_data_point.to_param, :population_characteristic_data_point => @population_characteristic_data_point.attributes
    assert_redirected_to population_characteristic_data_point_path(assigns(:population_characteristic_data_point))
  end

  test "should destroy population_characteristic_data_point" do
    assert_difference('PopulationCharacteristicDataPoint.count', -1) do
      delete :destroy, :id => @population_characteristic_data_point.to_param
    end

    assert_redirected_to population_characteristic_data_points_path
  end
end

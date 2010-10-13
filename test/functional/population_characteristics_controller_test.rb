require 'test_helper'

class PopulationCharacteristicsControllerTest < ActionController::TestCase
  setup do
    @population_characteristic = population_characteristics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:population_characteristics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create population_characteristic" do
    assert_difference('PopulationCharacteristic.count') do
      post :create, :population_characteristic => @population_characteristic.attributes
    end

    assert_redirected_to population_characteristic_path(assigns(:population_characteristic))
  end

  test "should show population_characteristic" do
    get :show, :id => @population_characteristic.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @population_characteristic.to_param
    assert_response :success
  end

  test "should update population_characteristic" do
    put :update, :id => @population_characteristic.to_param, :population_characteristic => @population_characteristic.attributes
    assert_redirected_to population_characteristic_path(assigns(:population_characteristic))
  end

  test "should destroy population_characteristic" do
    assert_difference('PopulationCharacteristic.count', -1) do
      delete :destroy, :id => @population_characteristic.to_param
    end

    assert_redirected_to population_characteristics_path
  end
end

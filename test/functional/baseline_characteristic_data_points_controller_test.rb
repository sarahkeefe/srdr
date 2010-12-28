require 'test_helper'

class BaselineCharacteristicDataPointsControllerTest < ActionController::TestCase
  setup do
    @baseline_characteristic_data_point = baseline_characteristic_data_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:baseline_characteristic_data_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create baseline_characteristic_data_point" do
    assert_difference('BaselineCharacteristicDataPoint.count') do
      post :create, :baseline_characteristic_data_point => @baseline_characteristic_data_point.attributes
    end

    assert_redirected_to baseline_characteristic_data_point_path(assigns(:baseline_characteristic_data_point))
  end

  test "should show baseline_characteristic_data_point" do
    get :show, :id => @baseline_characteristic_data_point.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @baseline_characteristic_data_point.to_param
    assert_response :success
  end

  test "should update baseline_characteristic_data_point" do
    put :update, :id => @baseline_characteristic_data_point.to_param, :baseline_characteristic_data_point => @baseline_characteristic_data_point.attributes
    assert_redirected_to baseline_characteristic_data_point_path(assigns(:baseline_characteristic_data_point))
  end

  test "should destroy baseline_characteristic_data_point" do
    assert_difference('BaselineCharacteristicDataPoint.count', -1) do
      delete :destroy, :id => @baseline_characteristic_data_point.to_param
    end

    assert_redirected_to baseline_characteristic_data_points_path
  end
end

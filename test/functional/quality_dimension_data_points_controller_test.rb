require 'test_helper'

class QualityDimensionDataPointsControllerTest < ActionController::TestCase
  setup do
    @quality_dimension_data_point = quality_dimension_data_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quality_dimension_data_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quality_dimension_data_point" do
    assert_difference('QualityDimensionDataPoint.count') do
      post :create, :quality_dimension_data_point => @quality_dimension_data_point.attributes
    end

    assert_redirected_to quality_dimension_data_point_path(assigns(:quality_dimension_data_point))
  end

  test "should show quality_dimension_data_point" do
    get :show, :id => @quality_dimension_data_point.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quality_dimension_data_point.to_param
    assert_response :success
  end

  test "should update quality_dimension_data_point" do
    put :update, :id => @quality_dimension_data_point.to_param, :quality_dimension_data_point => @quality_dimension_data_point.attributes
    assert_redirected_to quality_dimension_data_point_path(assigns(:quality_dimension_data_point))
  end

  test "should destroy quality_dimension_data_point" do
    assert_difference('QualityDimensionDataPoint.count', -1) do
      delete :destroy, :id => @quality_dimension_data_point.to_param
    end

    assert_redirected_to quality_dimension_data_points_path
  end
end

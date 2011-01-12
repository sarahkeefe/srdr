require 'test_helper'

class DesignDetailDataPointsControllerTest < ActionController::TestCase
  setup do
    @design_detail_data_point = design_detail_data_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:design_detail_data_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create design_detail_data_point" do
    assert_difference('DesignDetailDataPoint.count') do
      post :create, :design_detail_data_point => @design_detail_data_point.attributes
    end

    assert_redirected_to design_detail_data_point_path(assigns(:design_detail_data_point))
  end

  test "should show design_detail_data_point" do
    get :show, :id => @design_detail_data_point.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @design_detail_data_point.to_param
    assert_response :success
  end

  test "should update design_detail_data_point" do
    put :update, :id => @design_detail_data_point.to_param, :design_detail_data_point => @design_detail_data_point.attributes
    assert_redirected_to design_detail_data_point_path(assigns(:design_detail_data_point))
  end

  test "should destroy design_detail_data_point" do
    assert_difference('DesignDetailDataPoint.count', -1) do
      delete :destroy, :id => @design_detail_data_point.to_param
    end

    assert_redirected_to design_detail_data_points_path
  end
end

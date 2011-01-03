require 'test_helper'

class QualityDimensionFieldsControllerTest < ActionController::TestCase
  setup do
    @quality_dimension_field = quality_dimension_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quality_dimension_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quality_dimension_field" do
    assert_difference('QualityDimensionField.count') do
      post :create, :quality_dimension_field => @quality_dimension_field.attributes
    end

    assert_redirected_to quality_dimension_field_path(assigns(:quality_dimension_field))
  end

  test "should show quality_dimension_field" do
    get :show, :id => @quality_dimension_field.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quality_dimension_field.to_param
    assert_response :success
  end

  test "should update quality_dimension_field" do
    put :update, :id => @quality_dimension_field.to_param, :quality_dimension_field => @quality_dimension_field.attributes
    assert_redirected_to quality_dimension_field_path(assigns(:quality_dimension_field))
  end

  test "should destroy quality_dimension_field" do
    assert_difference('QualityDimensionField.count', -1) do
      delete :destroy, :id => @quality_dimension_field.to_param
    end

    assert_redirected_to quality_dimension_fields_path
  end
end

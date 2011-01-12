require 'test_helper'

class DesignDetailFieldsControllerTest < ActionController::TestCase
  setup do
    @design_detail_field = design_detail_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:design_detail_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create design_detail_field" do
    assert_difference('DesignDetailField.count') do
      post :create, :design_detail_field => @design_detail_field.attributes
    end

    assert_redirected_to design_detail_field_path(assigns(:design_detail_field))
  end

  test "should show design_detail_field" do
    get :show, :id => @design_detail_field.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @design_detail_field.to_param
    assert_response :success
  end

  test "should update design_detail_field" do
    put :update, :id => @design_detail_field.to_param, :design_detail_field => @design_detail_field.attributes
    assert_redirected_to design_detail_field_path(assigns(:design_detail_field))
  end

  test "should destroy design_detail_field" do
    assert_difference('DesignDetailField.count', -1) do
      delete :destroy, :id => @design_detail_field.to_param
    end

    assert_redirected_to design_detail_fields_path
  end
end

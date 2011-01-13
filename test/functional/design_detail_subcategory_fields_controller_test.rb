require 'test_helper'

class DesignDetailSubcategoryFieldsControllerTest < ActionController::TestCase
  setup do
    @design_detail_subcategory_field = design_detail_subcategory_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:design_detail_subcategory_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create design_detail_subcategory_field" do
    assert_difference('DesignDetailSubcategoryField.count') do
      post :create, :design_detail_subcategory_field => @design_detail_subcategory_field.attributes
    end

    assert_redirected_to design_detail_subcategory_field_path(assigns(:design_detail_subcategory_field))
  end

  test "should show design_detail_subcategory_field" do
    get :show, :id => @design_detail_subcategory_field.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @design_detail_subcategory_field.to_param
    assert_response :success
  end

  test "should update design_detail_subcategory_field" do
    put :update, :id => @design_detail_subcategory_field.to_param, :design_detail_subcategory_field => @design_detail_subcategory_field.attributes
    assert_redirected_to design_detail_subcategory_field_path(assigns(:design_detail_subcategory_field))
  end

  test "should destroy design_detail_subcategory_field" do
    assert_difference('DesignDetailSubcategoryField.count', -1) do
      delete :destroy, :id => @design_detail_subcategory_field.to_param
    end

    assert_redirected_to design_detail_subcategory_fields_path
  end
end

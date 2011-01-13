require 'test_helper'

class DefaultDesignDetailsControllerTest < ActionController::TestCase
  setup do
    @default_design_detail = default_design_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:default_design_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create default_design_detail" do
    assert_difference('DefaultDesignDetail.count') do
      post :create, :default_design_detail => @default_design_detail.attributes
    end

    assert_redirected_to default_design_detail_path(assigns(:default_design_detail))
  end

  test "should show default_design_detail" do
    get :show, :id => @default_design_detail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @default_design_detail.to_param
    assert_response :success
  end

  test "should update default_design_detail" do
    put :update, :id => @default_design_detail.to_param, :default_design_detail => @default_design_detail.attributes
    assert_redirected_to default_design_detail_path(assigns(:default_design_detail))
  end

  test "should destroy default_design_detail" do
    assert_difference('DefaultDesignDetail.count', -1) do
      delete :destroy, :id => @default_design_detail.to_param
    end

    assert_redirected_to default_design_details_path
  end
end

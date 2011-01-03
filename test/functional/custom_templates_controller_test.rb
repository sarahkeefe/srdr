require 'test_helper'

class CustomTemplatesControllerTest < ActionController::TestCase
  setup do
    @custom_template = custom_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_template" do
    assert_difference('CustomTemplate.count') do
      post :create, :custom_template => @custom_template.attributes
    end

    assert_redirected_to custom_template_path(assigns(:custom_template))
  end

  test "should show custom_template" do
    get :show, :id => @custom_template.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @custom_template.to_param
    assert_response :success
  end

  test "should update custom_template" do
    put :update, :id => @custom_template.to_param, :custom_template => @custom_template.attributes
    assert_redirected_to custom_template_path(assigns(:custom_template))
  end

  test "should destroy custom_template" do
    assert_difference('CustomTemplate.count', -1) do
      delete :destroy, :id => @custom_template.to_param
    end

    assert_redirected_to custom_templates_path
  end
end

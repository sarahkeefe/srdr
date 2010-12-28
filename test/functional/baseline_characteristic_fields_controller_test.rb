require 'test_helper'

class BaselineCharacteristicFieldsControllerTest < ActionController::TestCase
  setup do
    @baseline_characteristic_field = baseline_characteristic_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:baseline_characteristic_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create baseline_characteristic_field" do
    assert_difference('BaselineCharacteristicField.count') do
      post :create, :baseline_characteristic_field => @baseline_characteristic_field.attributes
    end

    assert_redirected_to baseline_characteristic_field_path(assigns(:baseline_characteristic_field))
  end

  test "should show baseline_characteristic_field" do
    get :show, :id => @baseline_characteristic_field.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @baseline_characteristic_field.to_param
    assert_response :success
  end

  test "should update baseline_characteristic_field" do
    put :update, :id => @baseline_characteristic_field.to_param, :baseline_characteristic_field => @baseline_characteristic_field.attributes
    assert_redirected_to baseline_characteristic_field_path(assigns(:baseline_characteristic_field))
  end

  test "should destroy baseline_characteristic_field" do
    assert_difference('BaselineCharacteristicField.count', -1) do
      delete :destroy, :id => @baseline_characteristic_field.to_param
    end

    assert_redirected_to baseline_characteristic_fields_path
  end
end

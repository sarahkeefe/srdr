require 'test_helper'

class StudyBaselineCharacteristicFieldsControllerTest < ActionController::TestCase
  setup do
    @study_baseline_characteristic_field = study_baseline_characteristic_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:study_baseline_characteristic_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create study_baseline_characteristic_field" do
    assert_difference('StudyBaselineCharacteristicField.count') do
      post :create, :study_baseline_characteristic_field => @study_baseline_characteristic_field.attributes
    end

    assert_redirected_to study_baseline_characteristic_field_path(assigns(:study_baseline_characteristic_field))
  end

  test "should show study_baseline_characteristic_field" do
    get :show, :id => @study_baseline_characteristic_field.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @study_baseline_characteristic_field.to_param
    assert_response :success
  end

  test "should update study_baseline_characteristic_field" do
    put :update, :id => @study_baseline_characteristic_field.to_param, :study_baseline_characteristic_field => @study_baseline_characteristic_field.attributes
    assert_redirected_to study_baseline_characteristic_field_path(assigns(:study_baseline_characteristic_field))
  end

  test "should destroy study_baseline_characteristic_field" do
    assert_difference('StudyBaselineCharacteristicField.count', -1) do
      delete :destroy, :id => @study_baseline_characteristic_field.to_param
    end

    assert_redirected_to study_baseline_characteristic_fields_path
  end
end

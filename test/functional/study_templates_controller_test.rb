require 'test_helper'

class StudyTemplatesControllerTest < ActionController::TestCase
  setup do
    @study_template = study_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:study_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create study_template" do
    assert_difference('StudyTemplate.count') do
      post :create, :study_template => @study_template.attributes
    end

    assert_redirected_to study_template_path(assigns(:study_template))
  end

  test "should show study_template" do
    get :show, :id => @study_template.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @study_template.to_param
    assert_response :success
  end

  test "should update study_template" do
    put :update, :id => @study_template.to_param, :study_template => @study_template.attributes
    assert_redirected_to study_template_path(assigns(:study_template))
  end

  test "should destroy study_template" do
    assert_difference('StudyTemplate.count', -1) do
      delete :destroy, :id => @study_template.to_param
    end

    assert_redirected_to study_templates_path
  end
end

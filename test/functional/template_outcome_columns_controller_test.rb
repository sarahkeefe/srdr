require 'test_helper'

class TemplateOutcomeColumnsControllerTest < ActionController::TestCase
  setup do
    @template_outcome_column = template_outcome_columns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:template_outcome_columns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create template_outcome_column" do
    assert_difference('TemplateOutcomeColumn.count') do
      post :create, :template_outcome_column => @template_outcome_column.attributes
    end

    assert_redirected_to template_outcome_column_path(assigns(:template_outcome_column))
  end

  test "should show template_outcome_column" do
    get :show, :id => @template_outcome_column.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @template_outcome_column.to_param
    assert_response :success
  end

  test "should update template_outcome_column" do
    put :update, :id => @template_outcome_column.to_param, :template_outcome_column => @template_outcome_column.attributes
    assert_redirected_to template_outcome_column_path(assigns(:template_outcome_column))
  end

  test "should destroy template_outcome_column" do
    assert_difference('TemplateOutcomeColumn.count', -1) do
      delete :destroy, :id => @template_outcome_column.to_param
    end

    assert_redirected_to template_outcome_columns_path
  end
end

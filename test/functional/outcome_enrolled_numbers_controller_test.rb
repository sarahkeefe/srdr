require 'test_helper'

class OutcomeEnrolledNumbersControllerTest < ActionController::TestCase
  setup do
    @outcome_enrolled_number = outcome_enrolled_numbers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_enrolled_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_enrolled_number" do
    assert_difference('OutcomeEnrolledNumber.count') do
      post :create, :outcome_enrolled_number => @outcome_enrolled_number.attributes
    end

    assert_redirected_to outcome_enrolled_number_path(assigns(:outcome_enrolled_number))
  end

  test "should show outcome_enrolled_number" do
    get :show, :id => @outcome_enrolled_number.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_enrolled_number.to_param
    assert_response :success
  end

  test "should update outcome_enrolled_number" do
    put :update, :id => @outcome_enrolled_number.to_param, :outcome_enrolled_number => @outcome_enrolled_number.attributes
    assert_redirected_to outcome_enrolled_number_path(assigns(:outcome_enrolled_number))
  end

  test "should destroy outcome_enrolled_number" do
    assert_difference('OutcomeEnrolledNumber.count', -1) do
      delete :destroy, :id => @outcome_enrolled_number.to_param
    end

    assert_redirected_to outcome_enrolled_numbers_path
  end
end

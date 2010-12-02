require 'test_helper'

class PublicationNumbersControllerTest < ActionController::TestCase
  setup do
    @publication_number = publication_numbers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:publication_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create publication_number" do
    assert_difference('PublicationNumber.count') do
      post :create, :publication_number => @publication_number.attributes
    end

    assert_redirected_to publication_number_path(assigns(:publication_number))
  end

  test "should show publication_number" do
    get :show, :id => @publication_number.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @publication_number.to_param
    assert_response :success
  end

  test "should update publication_number" do
    put :update, :id => @publication_number.to_param, :publication_number => @publication_number.attributes
    assert_redirected_to publication_number_path(assigns(:publication_number))
  end

  test "should destroy publication_number" do
    assert_difference('PublicationNumber.count', -1) do
      delete :destroy, :id => @publication_number.to_param
    end

    assert_redirected_to publication_numbers_path
  end
end

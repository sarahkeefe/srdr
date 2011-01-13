require 'test_helper'

class PrimaryPublicationNumbersControllerTest < ActionController::TestCase
  setup do
    @primary_publication_number = primary_publication_numbers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:primary_publication_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create primary_publication_number" do
    assert_difference('PrimaryPublicationNumber.count') do
      post :create, :primary_publication_number => @primary_publication_number.attributes
    end

    assert_redirected_to primary_publication_number_path(assigns(:primary_publication_number))
  end

  test "should show primary_publication_number" do
    get :show, :id => @primary_publication_number.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @primary_publication_number.to_param
    assert_response :success
  end

  test "should update primary_publication_number" do
    put :update, :id => @primary_publication_number.to_param, :primary_publication_number => @primary_publication_number.attributes
    assert_redirected_to primary_publication_number_path(assigns(:primary_publication_number))
  end

  test "should destroy primary_publication_number" do
    assert_difference('PrimaryPublicationNumber.count', -1) do
      delete :destroy, :id => @primary_publication_number.to_param
    end

    assert_redirected_to primary_publication_numbers_path
  end
end

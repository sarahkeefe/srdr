require 'test_helper'

class PrimaryPublicationsControllerTest < ActionController::TestCase
  setup do
    @primary_publication = primary_publications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:primary_publications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create primary_publication" do
    assert_difference('PrimaryPublication.count') do
      post :create, :primary_publication => @primary_publication.attributes
    end

    assert_redirected_to primary_publication_path(assigns(:primary_publication))
  end

  test "should show primary_publication" do
    get :show, :id => @primary_publication.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @primary_publication.to_param
    assert_response :success
  end

  test "should update primary_publication" do
    put :update, :id => @primary_publication.to_param, :primary_publication => @primary_publication.attributes
    assert_redirected_to primary_publication_path(assigns(:primary_publication))
  end

  test "should destroy primary_publication" do
    assert_difference('PrimaryPublication.count', -1) do
      delete :destroy, :id => @primary_publication.to_param
    end

    assert_redirected_to primary_publications_path
  end
end

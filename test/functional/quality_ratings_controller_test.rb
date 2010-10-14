require 'test_helper'

class QualityRatingsControllerTest < ActionController::TestCase
  setup do
    @quality_rating = quality_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quality_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quality_rating" do
    assert_difference('QualityRating.count') do
      post :create, :quality_rating => @quality_rating.attributes
    end

    assert_redirected_to quality_rating_path(assigns(:quality_rating))
  end

  test "should show quality_rating" do
    get :show, :id => @quality_rating.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quality_rating.to_param
    assert_response :success
  end

  test "should update quality_rating" do
    put :update, :id => @quality_rating.to_param, :quality_rating => @quality_rating.attributes
    assert_redirected_to quality_rating_path(assigns(:quality_rating))
  end

  test "should destroy quality_rating" do
    assert_difference('QualityRating.count', -1) do
      delete :destroy, :id => @quality_rating.to_param
    end

    assert_redirected_to quality_ratings_path
  end
end

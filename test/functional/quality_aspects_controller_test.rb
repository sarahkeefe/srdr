require 'test_helper'

class QualityAspectsControllerTest < ActionController::TestCase
  setup do
    @quality_aspect = quality_aspects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quality_aspects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quality_aspect" do
    assert_difference('QualityAspect.count') do
      post :create, :quality_aspect => @quality_aspect.attributes
    end

    assert_redirected_to quality_aspect_path(assigns(:quality_aspect))
  end

  test "should show quality_aspect" do
    get :show, :id => @quality_aspect.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quality_aspect.to_param
    assert_response :success
  end

  test "should update quality_aspect" do
    put :update, :id => @quality_aspect.to_param, :quality_aspect => @quality_aspect.attributes
    assert_redirected_to quality_aspect_path(assigns(:quality_aspect))
  end

  test "should destroy quality_aspect" do
    assert_difference('QualityAspect.count', -1) do
      delete :destroy, :id => @quality_aspect.to_param
    end

    assert_redirected_to quality_aspects_path
  end
end

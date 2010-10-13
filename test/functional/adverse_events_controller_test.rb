require 'test_helper'

class AdverseEventsControllerTest < ActionController::TestCase
  setup do
    @adverse_event = adverse_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adverse_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adverse_event" do
    assert_difference('AdverseEvent.count') do
      post :create, :adverse_event => @adverse_event.attributes
    end

    assert_redirected_to adverse_event_path(assigns(:adverse_event))
  end

  test "should show adverse_event" do
    get :show, :id => @adverse_event.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @adverse_event.to_param
    assert_response :success
  end

  test "should update adverse_event" do
    put :update, :id => @adverse_event.to_param, :adverse_event => @adverse_event.attributes
    assert_redirected_to adverse_event_path(assigns(:adverse_event))
  end

  test "should destroy adverse_event" do
    assert_difference('AdverseEvent.count', -1) do
      delete :destroy, :id => @adverse_event.to_param
    end

    assert_redirected_to adverse_events_path
  end
end

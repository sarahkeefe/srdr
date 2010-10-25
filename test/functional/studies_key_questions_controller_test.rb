require 'test_helper'

class StudiesKeyQuestionsControllerTest < ActionController::TestCase
  setup do
    @studies_key_question = studies_key_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studies_key_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create studies_key_question" do
    assert_difference('StudiesKeyQuestion.count') do
      post :create, :studies_key_question => @studies_key_question.attributes
    end

    assert_redirected_to studies_key_question_path(assigns(:studies_key_question))
  end

  test "should show studies_key_question" do
    get :show, :id => @studies_key_question.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @studies_key_question.to_param
    assert_response :success
  end

  test "should update studies_key_question" do
    put :update, :id => @studies_key_question.to_param, :studies_key_question => @studies_key_question.attributes
    assert_redirected_to studies_key_question_path(assigns(:studies_key_question))
  end

  test "should destroy studies_key_question" do
    assert_difference('StudiesKeyQuestion.count', -1) do
      delete :destroy, :id => @studies_key_question.to_param
    end

    assert_redirected_to studies_key_questions_path
  end
end

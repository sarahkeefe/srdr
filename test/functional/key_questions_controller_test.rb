require 'test_helper'

class KeyQuestionsControllerTest < ActionController::TestCase
  setup do
    @key_question = key_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:key_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create key_question" do
    assert_difference('KeyQuestion.count') do
      post :create, :key_question => @key_question.attributes
    end

    assert_redirected_to key_question_path(assigns(:key_question))
  end

  test "should show key_question" do
    get :show, :id => @key_question.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @key_question.to_param
    assert_response :success
  end

  test "should update key_question" do
    put :update, :id => @key_question.to_param, :key_question => @key_question.attributes
    assert_redirected_to key_question_path(assigns(:key_question))
  end

  test "should destroy key_question" do
    assert_difference('KeyQuestion.count', -1) do
      delete :destroy, :id => @key_question.to_param
    end

    assert_redirected_to key_questions_path
  end
end

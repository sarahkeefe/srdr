require 'test_helper'

class OutcomeResultsNotesControllerTest < ActionController::TestCase
  setup do
    @outcome_results_note = outcome_results_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outcome_results_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outcome_results_note" do
    assert_difference('OutcomeResultsNote.count') do
      post :create, :outcome_results_note => @outcome_results_note.attributes
    end

    assert_redirected_to outcome_results_note_path(assigns(:outcome_results_note))
  end

  test "should show outcome_results_note" do
    get :show, :id => @outcome_results_note.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @outcome_results_note.to_param
    assert_response :success
  end

  test "should update outcome_results_note" do
    put :update, :id => @outcome_results_note.to_param, :outcome_results_note => @outcome_results_note.attributes
    assert_redirected_to outcome_results_note_path(assigns(:outcome_results_note))
  end

  test "should destroy outcome_results_note" do
    assert_difference('OutcomeResultsNote.count', -1) do
      delete :destroy, :id => @outcome_results_note.to_param
    end

    assert_redirected_to outcome_results_notes_path
  end
end

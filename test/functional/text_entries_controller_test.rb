require 'test_helper'

class TextEntriesControllerTest < ActionController::TestCase
  setup do
    @text_entry = text_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:text_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create text_entry" do
    assert_difference('TextEntry.count') do
      post :create, text_entry: { jurisdiction_id: @text_entry.jurisdiction_id, statute_type_id: @text_entry.statute_type_id, text_value: @text_entry.text_value }
    end

    assert_redirected_to text_entry_path(assigns(:text_entry))
  end

  test "should show text_entry" do
    get :show, id: @text_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @text_entry
    assert_response :success
  end

  test "should update text_entry" do
    put :update, id: @text_entry, text_entry: { jurisdiction_id: @text_entry.jurisdiction_id, statute_type_id: @text_entry.statute_type_id, text_value: @text_entry.text_value }
    assert_redirected_to text_entry_path(assigns(:text_entry))
  end

  test "should destroy text_entry" do
    assert_difference('TextEntry.count', -1) do
      delete :destroy, id: @text_entry
    end

    assert_redirected_to text_entries_path
  end
end

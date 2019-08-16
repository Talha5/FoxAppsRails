require 'test_helper'

class StatuteTypesControllerTest < ActionController::TestCase
  setup do
    @statute_type = statute_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statute_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statute_type" do
    assert_difference('StatuteType.count') do
      post :create, statute_type: { name: @statute_type.name }
    end

    assert_redirected_to statute_type_path(assigns(:statute_type))
  end

  test "should show statute_type" do
    get :show, id: @statute_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @statute_type
    assert_response :success
  end

  test "should update statute_type" do
    put :update, id: @statute_type, statute_type: { name: @statute_type.name }
    assert_redirected_to statute_type_path(assigns(:statute_type))
  end

  test "should destroy statute_type" do
    assert_difference('StatuteType.count', -1) do
      delete :destroy, id: @statute_type
    end

    assert_redirected_to statute_types_path
  end
end

require 'test_helper'

class JurisdictionsControllerTest < ActionController::TestCase
  setup do
    @jurisdiction = jurisdictions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jurisdictions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jurisdiction" do
    assert_difference('Jurisdiction.count') do
      post :create, jurisdiction: { name: @jurisdiction.name }
    end

    assert_redirected_to jurisdiction_path(assigns(:jurisdiction))
  end

  test "should show jurisdiction" do
    get :show, id: @jurisdiction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jurisdiction
    assert_response :success
  end

  test "should update jurisdiction" do
    put :update, id: @jurisdiction, jurisdiction: { name: @jurisdiction.name }
    assert_redirected_to jurisdiction_path(assigns(:jurisdiction))
  end

  test "should destroy jurisdiction" do
    assert_difference('Jurisdiction.count', -1) do
      delete :destroy, id: @jurisdiction
    end

    assert_redirected_to jurisdictions_path
  end
end

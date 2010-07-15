require 'test_helper'

class FestivalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:festivals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create festival" do
    assert_difference('Festival.count') do
      post :create, :festival => { }
    end

    assert_redirected_to festival_path(assigns(:festival))
  end

  test "should show festival" do
    get :show, :id => festivals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => festivals(:one).to_param
    assert_response :success
  end

  test "should update festival" do
    put :update, :id => festivals(:one).to_param, :festival => { }
    assert_redirected_to festival_path(assigns(:festival))
  end

  test "should destroy festival" do
    assert_difference('Festival.count', -1) do
      delete :destroy, :id => festivals(:one).to_param
    end

    assert_redirected_to festivals_path
  end
end

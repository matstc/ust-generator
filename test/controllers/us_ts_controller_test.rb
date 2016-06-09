require 'test_helper'

class UsTsControllerTest < ActionController::TestCase
  setup do
    @ust = usts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ust" do
    assert_difference('Ust.count') do
      post :create, ust: { chord: @ust.chord, quality: @ust.quality }
    end

    assert_redirected_to ust_path(assigns(:ust))
  end

  test "should show ust" do
    get :show, id: @ust
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ust
    assert_response :success
  end

  test "should update ust" do
    patch :update, id: @ust, ust: { chord: @ust.chord, quality: @ust.quality }
    assert_redirected_to ust_path(assigns(:ust))
  end

  test "should destroy ust" do
    assert_difference('Ust.count', -1) do
      delete :destroy, id: @ust
    end

    assert_redirected_to usts_path
  end
end

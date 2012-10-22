require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "all REST call are ok" do
    get 'index'
    assert_response :success
    post 'index'
    assert_response :success
    put 'index'
    assert_response :success
    delete 'index'
    assert_response :success
    head 'index'
    assert_response :success
  end

end

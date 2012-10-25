require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  fixtures :all

  context "logging in with bad details" do
    setup { post 'create', { :email => 'dave@animals.com', :password => 'password' } }
    should respond_with(:success)
    should "display alert message" do
      assert flash[:alert]
    end
    should "not set session" do
      assert ! session[:user_id]
    end
  end

  context "logging in with good details" do
    setup { post 'create', { :email => 'dave@people.com', :password => 'password' } }
    should respond_with(:redirect)
    should "display notice message" do
      assert flash[:notice]
    end
    should "set session" do
      assert session[:user_id]
    end
  end

  context "logging out" do
    setup { delete 'destroy' }
    should respond_with(:redirect)
    should "display notice message" do
      assert flash[:notice]
    end
    should "unset session" do
      assert ! session[:user_id]
    end
  end
end

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :all

  context "signing up with bad details" do
    setup { post 'create', :user => {:email => 'ben', :password => 'password', :password_confirmation => 'password'} }
    should respond_with(:success)
    should "display alert message" do
      assert flash[:alert]
    end
    should "not set session" do
      assert ! session[:user_id]
    end
  end

  context "signing up with good details" do
    setup { post 'create', :user => {:email => 'ben@people.com', :password => 'password', :password_confirmation => 'password'} }
    should respond_with(:redirect)
    should "display notice message" do
      assert flash[:notice]
    end
    should "set session" do
      assert session[:user_id]
    end
  end

end


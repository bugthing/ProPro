require 'test_helper'

class BuilderControllerTest < ActionController::TestCase
  fixtures :all

  context "when trying to use builder without user session" do
    setup { get 'index' }
    should respond_with(:redirect)
    should "display alert message" do
      assert flash[:alert]
    end
  end

  context "when trying to use builder with user session" do
    setup do
      session[:user_id] = User.find_by_email('dave@people.com').id
      get 'index'
    end
    should respond_with(:success)
    should "display no message" do
      assert flash.empty?
    end
  end


end

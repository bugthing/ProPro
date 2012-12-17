require 'test_helper'

class BuilderControllerTest < ActionController::TestCase
  fixtures :all

  context "when trying to use builder without user session" do
    setup { get 'index' }
    should respond_with(:redirect)
    should "display alert message" do
      assert flash[:alert]
    end

    context "with a bad session id" do
      setup do
        session[:user_id] = 999
        get 'index'
      end
      should respond_with(:redirect)
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

  context 'logged in with a chart id' do
    setup do
      log_dave_in_via_session
      @chart_id = Chart.all.first.id
      get :show, { :id => @chart_id }
    end
 
    should "provide section connections" do
      assert_not_nil assigns[:chart]
      assert_not_nil assigns[:sections_connections]
    end

    context 'requesting connection data' do
      setup do
        get :connections, { :id => @chart_id }
      end
  
      should "provide section connections" do
        assert_not_nil assigns[:sections_connections]
      end
    end
  end

end

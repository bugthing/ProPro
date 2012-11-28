require 'test_helper'

class ToolsControllerTest < ActionController::TestCase
  fixtures :all

  context 'deny access to restful api' do
    setup { get :index }
    should respond_with(:redirect)
  end

  context "logged in" do
    setup do
      log_dave_in_via_session
    end

    context "a GET request" do
      setup { get :index }

      should "provide tools data" do
        assert_not_nil assigns[:tools]
      end
    end

  end

end

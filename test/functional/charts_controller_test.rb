require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  fixtures :all

  context 'deny access to restful api' do
    setup { get :index }
    should respond_with(:redirect)
  end

  context 'logged in' do
    setup do
      log_dave_in_via_session
    end

    context 'restful api (get)' do
      setup { get :index }
      should respond_with(:success)
    end

    context 'restful api (post)' do
      setup { post :create, chart: { name: 'Test Chart Three'} }
      should respond_with(:created)
    end
  end

end


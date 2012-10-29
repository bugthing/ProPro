require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  fixtures :all

  context 'deny access to restful api' do
    setup do
      get :index,  {format: :json}
    end
    should respond_with(:redirect)
  end

  context 'logged in' do
    setup do
      session[:user_id] = User.find_by_email('dave@people.com').id
    end

    context 'restful api (get)' do
      setup { get :index,  {format: :json} }
      should respond_with(:success)
    end

    context 'restful api (post)' do
      setup { 
        post :create,
        {chart: { name: 'Test Chart Three'}},
        {format: :json}
      #puts "****>#{ @request.headers }<****************"
      #puts "****>#{ @response.inspect }<****************"
      }
      #, {:chart => { :name => 'Test Chart Three'}},  {format: :json} }
      #should respond_with(:success)
    end
  end

end


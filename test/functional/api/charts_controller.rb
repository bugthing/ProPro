require 'test_helper'

class Api::ChartsControllerTest < ActionController::TestCase
  fixtures :all

  def valid_params
    { api_key: users(:user_one).api_key }
  end

  context "GET list" do
    setup { get :index, valid_params }
    should "give list of chart info" do
      expected = { "charts" => [ {"id" => 835977029, "name"=>"Chart One"} ] }
      assert_equal expected.to_json, response.body 
    end
  end
  
  context "GET details" do
    setup { get :show, valid_params.merge(id:charts(:chart_one).id) }
    should "give json of chart data" do
      expected = {"id" => 835977029, "name"=>"Chart One"}
      assert_equal expected.to_json, response.body 
    end
  end
  
end


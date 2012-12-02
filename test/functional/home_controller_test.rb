require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  fixtures :all

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

  def test_routes
    assert_routing "builder",   { :controller => 'builder', :action => 'index' }
    assert_routing "builder/1", { :controller => 'builder', :action => 'show'  , :id => "1" }
    assert_routing "charts",    { :controller => 'charts',  :action => 'index' }
    assert_routing "charts/1",  { :controller => 'charts',  :action => 'show'  , :id => "1" }

    assert_routing "charts/1/sections",   { :controller => 'sections',:action => 'index',  :chart_id => "1"  }
    assert_routing "charts/1/sections/1", { :controller => 'sections',:action => 'show' ,  :chart_id => "1", :id => "1" }
    assert_routing "charts/1/sections/1/section_lines",   { :controller => 'section_lines',:action => 'index' , :chart_id => "1", :section_id => "1" }
    assert_routing "charts/1/sections/1/section_lines/1", { :controller => 'section_lines',:action => 'show' ,  :chart_id => "1", :section_id => "1", :id => "1" }
  end

end

require 'test_helper'

class SectionLinesControllerTest < ActionController::TestCase
  fixtures :all

  context 'deny access to restful api' do
    setup { get :index }
    should respond_with(:redirect)
  end

  context "logged in, with a section id" do
    setup do
      log_dave_in_via_session
      @section_line = SectionLine.all.first
    end

    context "a GET JSON request" do
      setup { get :show, { :id => @section_line.id, :format => :json  } }

      should "provide section line data" do
        assert_not_nil assigns[:section_line]
        # parse json response.
        body = JSON.parse(response.body)
        assert_equal body["section_line"]["id"],  @section_line.id
      end
    end

    context "a GET HTML request" do
      setup { get :show, { :id => @section_line.id, :format => :html } }

      should "provide section data" do
        assert_not_nil assigns[:section_line]
        assert_tag :tag => "div"
      end
    end

    context "a POST HTML update request" do
      setup do
        post :update, { :id => @section_line.id, :weight => 10, :format => :html }
      end
 
      should "have updated the section line weight" do
        @section_line.reload
        assert_equal 10, @section_line.weight
      end
    end

    context "a POST request" do
      setup do
        @section = Section.all.first
        @tool = Tool.all.first
        post :create, chart_id:@section.chart.id, section_id:@section.id, tool_id:@tool.id
      end

      should "provide section line data" do
        assert_not_nil assigns[:section_line]
      end
    end

    context "a DELETE request" do
      setup do
        delete :destroy, chart_id:@section_line.section.chart.id, section_id:@section_line.section.id, id:@section_line.id
      end

      should "provide section line data" do
        assert_not_nil assigns[:section_line]
      end
    end

  end

end

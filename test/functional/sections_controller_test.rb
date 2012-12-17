require 'test_helper'

class SectionsControllerTest < ActionController::TestCase
  fixtures :all

  setup do
  end

  context 'deny access to restful api' do
    setup { get :index }
    should respond_with(:redirect)
  end

  context "logged in, with a section id" do
    setup do
      log_dave_in_via_session
      @section_id = Section.all.first.id
    end

    context "a GET JSON request" do
      setup { get :show, { :id => @section_id, :format => :json } }

      should "provide section data" do
        assert_not_nil assigns[:section]

        # parse json response.
        body = JSON.parse(response.body)
        assert_equal body["section"]["id"],  @section_id
      end
    end

    context "a GET HTML request" do
      setup { get :show, { :id => @section_id, :format => :html } }

      should "provide section data" do
        assert true
        assert_not_nil assigns[:section]
        assert_not_nil assigns[:section_line_tools]
        assert_tag :tag => "div", :attributes => { :id => "section-builder-lines" }
      end
    end

    context "a POST HTML create request" do
      setup do
        @chart_id = Chart.all.first.id
        post :create, { :chart_id => @chart_id, :name => 'New Section', :format => :html }
      end
      should "create a new section" do
        assert_not_nil assigns[:section]
      end
    end

    context "a POST HTML create request with a from section" do
      setup do
        chart = Chart.all.first
        @chart_id = chart.id
        @from_section_id = chart.sections.first.id
        post :create, { :chart_id => @chart_id, :name => 'New Section', :from_section_id => @from_section_id, :format => :html }
      end
      should "create a new section with a new section line" do
        assert_not_nil assigns[:section]
      end
    end

    context "a POST HTML update request" do
      setup do
        section = Section.find(@section_id)
        # construct a hash to replicate a form submission
        form = Hash.new
        section.section_lines.each do |sl|
          if sl.tool.name == 'Plain Text' then
            form["text_#{sl.id}"] = "Some plain old text"
          elsif sl.tool.name == 'Input Box' then
            form["data_name_#{sl.id}"] = "theNameOfData"
            form["data_label_#{sl.id}"] = "theLabelForInput"
          elsif sl.tool.name == 'Next Button' then
            form["button_text_#{sl.id}"] = "The Text For Button"
            form["onward_section_id_#{sl.id}"] = "789"
          end
        end
        post :update, { :id => @section_id, :format => :html }.merge( form )
      end

      should "provide section form with data" do
        assert_not_nil assigns[:section]
        assert_not_nil assigns[:section_line_tools]
        assert_tag :tag => "div", :attributes => { :id => "section-builder-lines" }
        assert_tag :tag => "input", :attributes => { :value => "The Text For Button" }
      end
    end

    context "a POST HTML update request with positional data" do
      setup do
        post :update, { :id => @section_id, :pos_left => 10, :pos_top => 20, :format => :html }
      end
      should "provide section form with data" do
        assert_equal 10, assigns[:section].pos_left
        assert_equal 20, assigns[:section].pos_top
      end
    end

    context "a DELETE JSON request" do
      setup { get :destroy, { :id => @section_id, :format => :json } }

      should "provide section data" do
        assert_not_nil assigns[:section]
        # parse json response.
        body = JSON.parse(response.body)
        assert_equal body["section"]["id"],  @section_id
      end
    end

  end

end

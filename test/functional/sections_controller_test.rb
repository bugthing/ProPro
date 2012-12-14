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

    context "a POST HTML request" do
      setup do

        # construct a hash to replicate a form submission
        section = Section.find(@section_id)
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

  end

end

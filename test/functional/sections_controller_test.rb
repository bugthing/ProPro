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
        assert_not_nil assigns[:section]
        assert_not_nil assigns[:tools]
        assert_tag :tag => "div", :attributes => { :id => "section-builder-lines" }
      end
    end


  end

end

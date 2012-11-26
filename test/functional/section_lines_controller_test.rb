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
      @section_line_id = SectionLine.all.first.id
    end

    context "a GET request" do
      setup { get :show, { :id => @section_line_id } }

      should "provide section line data" do
        assert_not_nil assigns[:section_line]
      end
    end

  end

end

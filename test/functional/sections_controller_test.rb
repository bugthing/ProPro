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

    context "a GET request" do
      setup { get :show, { :id => @section_id } }

      should "provide section data" do
        assert_not_nil assigns[:section]
      end
    end

  end

end

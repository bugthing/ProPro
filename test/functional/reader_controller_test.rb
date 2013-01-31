require 'test_helper'

class ReaderControllerTest < ActionController::TestCase
  fixtures :all

  context "with a chart id" do
    setup { @chart_id = Chart.first.id }
    context "when trying to use reader without an existing reader id" do
      setup { get 'show', { chart_id: @chart_id, id: 0 } }
      should respond_with(:success)
      should "render a reader form" do
        assert_tag :tag => "form", :attributes => { method:"post" }
      end
      context "when posting the reader form" do
        setup do
          @reading = Reading.all.last
          post 'update', { id: @reading.id, 'next_button' => 'NEXT' }
        end
        should respond_with(:success)
        should "move to next reading_section" do
          assert_tag :tag => "form", :attributes => { method:"post" }
        end
      end
    end
  end

end


require 'test_helper'
 
class TestProProTool < ActiveSupport::TestCase

  context "with a section line" do
    setup do
      @section_line = stub("SectionLine")
      @section_line.stubs(:id).returns(123)
    end

    context "and base class for ProPro::Tool's" do
      setup do
        @tool = ProPro::Tool.new(@section_line)
      end

      should "have some API to use" do
        assert_equal 'tool', @tool.ref
        assert_equal [], @tool.onward_sections
        assert_equal false, @tool.has_onward_sections?
        assert_equal '', @tool.edit_html
      end
    end
  end

end

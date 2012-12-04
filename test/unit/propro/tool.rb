
require 'test_helper'
 
class TestProProTool < ActiveSupport::TestCase

  context "with a section line" do
    setup do
      @section_line = stub("SectionLine")
      @section_line.stubs(:id).returns(123)
      @section_line.stubs(:sibling_sections).returns([])
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
        assert_equal false, @tool.edit_data({})
      end
    end

    context "with a NextButton and a section line" do
      setup do
        @section = stub("Section")
        @section.stubs(:id).returns(234)
        @section.stubs(:name).returns("Sibling Section")

        @section_line.stubs(:sibling_sections).returns([@section])
        @tool = ProPro::Tool::NextButton.new(@section_line)
      end

      should "have some html that gets saved" do
        assert_match /<input/, @tool.edit_html
        assert_match /<option value='234'>Sibling Section/, @tool.edit_html
        assert_equal true, @tool.edit_data({ 'button_text' => 'Move On', 'onward_section_id' => '1234' })
      end

    end
  end

end

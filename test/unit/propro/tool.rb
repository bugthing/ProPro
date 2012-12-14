
require 'test_helper'
 
class TestProProTool < ActiveSupport::TestCase

  context "with a section line adapter" do
    setup do
      @section_line_adapter = stub("ProPro::SectionAdapter")
    end

    context "and base class for ProPro::Tool's" do
      setup do
        @tool = ProPro::Tool.new( @section_line_adapter )
      end

      should "have some API to use" do
        assert_equal [], @tool.onward_sections
        assert_equal false, @tool.has_onward_sections?
        assert_equal '', @tool.edit_html
      end
    end

    context "with a NextButton and a section line" do
      setup do
        @sib_section = stub("Section")
        @sib_section.stubs(:name).returns("Sibling Section")
        @sib_section.stubs(:id).returns(234)

        @section_line_adapter = stub("ProPro::SectionAdapter")
        @section_line_adapter.stubs(:section_line_ref).returns('234')
        @section_line_adapter.stubs(:sibling_sections).returns([@sib_section])
        @section_line_adapter.stubs(:edit_data).returns({ button_text:'Move On', onward_section_id:''})
        @section_line_adapter.stubs(:edit_data=).returns(true)

        @tool = ProPro::Tool::NextButton.new( @section_line_adapter )
      end

      should "have some html that gets saved and read" do
        assert_match /<option value='234' >Sibling Section/, @tool.edit_html
        @section_line_adapter.stubs(:edit_data).returns({ button_text:'Move On', onward_section_id:'234'})
        assert_match /<option value='234' selected>Sibling Section/, @tool.edit_html
      end

    end
  end

end

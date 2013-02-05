require 'test_helper'

class SectionLineTest < ActiveSupport::TestCase
  should belong_to(:tool)
  should belong_to(:section)

  context "section line" do
    fixtures :all
    setup do
      @section_line = Section.find_by_name('Section One').section_lines.first
    end

    should "have a propro tool" do
      assert @section_line.respond_to?(:propro_tool)
      assert @section_line.propro_tool.kind_of?( ProPro::Tool )
    end

    context "added a new section" do
      setup do
        @new_section_line = @section_line.section.section_lines.create({:tool_id => @section_line.tool.id})
      end
      should "have a weight of 2 set" do
        assert_equal 2, @new_section_line.weight
      end
    end
  end

end

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
  end

end

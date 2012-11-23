require 'test_helper'

class SectionLineTest < ActiveSupport::TestCase
  fixtures :all

  test "section line one" do
    sl = SectionLine.all.first
    assert sl.respond_to?(:outgoing_sections)
    assert sl.respond_to?(:section_line_tool)

    slt = sl.section_line_tool
    puts "GOT: #{slt}"
    assert slt
  end

end

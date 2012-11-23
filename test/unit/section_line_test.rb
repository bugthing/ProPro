require 'test_helper'

class SectionLineTest < ActiveSupport::TestCase
  fixtures :all

  test "section line one" do
    SectionLine.all.each do |sl|
      assert sl.respond_to?(:outgoing_sections)
      assert sl.respond_to?(:section_line_tool)
      slt = sl.outgoing_sections
      puts "GOT: #{slt}"
      assert slt
    end
  end

end

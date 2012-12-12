require 'test_helper'

class SectionLineTest < ActiveSupport::TestCase
  fixtures :all

  test "section line one" do
    SectionLine.all.each do |sl|
      assert sl
      assert sl.section
      assert sl.tool
    end
  end

end

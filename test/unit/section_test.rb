require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  fixtures :all

  test "section one" do
    s = Section.find_by_name('Section One')
    assert s.respond_to?(:section_lines)

    ss = s.sibling_sections
    assert_equal ["Section Three", "Section Two"], ss.map{ |s| s.name }.sort

  end

end


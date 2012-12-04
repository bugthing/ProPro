require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  fixtures :all

  test "section one" do
    s = Section.find_by_name('Section One')
    assert s.respond_to?(:outgoing_sections)

    os = s.outgoing_sections
    assert os

    ss = s.sibling_sections
    assert_equal ["Section Three", "Section Two"], ss.map{ |s| s.name }.sort

  end

end


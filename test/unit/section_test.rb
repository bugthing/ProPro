require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  should belong_to(:chart)
  should have_many(:section_lines)

  context "section one" do
    fixtures :all
    setup do
      @section = Section.find_by_name('Section One')
    end

    should "tell me about sibling sections" do
      assert @section.respond_to?(:sibling_sections)
      assert_equal ["Section Three", "Section Two"], @section.sibling_sections.map{ |s| s.name }.sort
    end
  end

end


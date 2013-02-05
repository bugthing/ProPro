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

    context "re-order section lines" do
      setup do
        section_lines = @section.section_lines
        @current_order = section_lines.map {|sl| sl.id}
        section_lines[0].weight = 2
        section_lines[1].weight = 1
        section_lines[0].save!
        section_lines[1].save!
      end
      should "return section lines ordered by weight" do
        assert_equal [@current_order[1], @current_order[0], @current_order[2]], @section.section_lines.map{|sl| sl.id }
      end
    end

  end

end


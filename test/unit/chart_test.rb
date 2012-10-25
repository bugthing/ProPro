require 'test_helper'

class ChartTest < ActiveSupport::TestCase
  fixtures :all
 
  test "chart fixtures" do 

    c = Chart.find_by_name('Chart One')

    #puts "Chart: #{c.name}"
    #puts "Sections: #{c.sections}"
    assert_equal "Chart One", c.name
    assert_equal 3, c.sections.count

    s = c.sections.find_by_name('Section One')
    #puts "Section: #{s.name}"
    #puts "Section Chart: #{s.chart.name}"
    #puts "Section Lines: #{s.section_lines}"
    assert_equal 3, s.section_lines.count

    sl = s.section_lines.last
    #puts "Section Line: #{sl.id}"
    #puts "Section Line Section: #{sl.section.name}"
    assert sl

    t = sl.tool
    #puts "Tool: #{t.name}"
    #puts "Tool User Group: #{t.user_group}"
    assert t.name

    ug = t.user_group
    #puts "User Group: #{ug.name}"
    #puts "User Group Users: #{ug.users}"
    #puts "User Group Tools: #{ug.tools}"
    #puts "User Group Users: #{ug.charts}"
    assert ug

    u = ug.users.find_by_email('dave@people.com');
    #puts "User: #{u.email}"
    #puts "User User Group: #{u.user_group}"
    assert u

  end

end

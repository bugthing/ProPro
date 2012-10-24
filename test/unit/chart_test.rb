require 'test_helper'

class ChartTest < ActiveSupport::TestCase
  fixtures :all
 
  test "chart" do 

    c = Chart.find_by_name('Chart One')
    c.save!

    puts "Chart: #{c.name}"
    puts "Sections: #{c.sections}"

    s = c.sections.find_by_name('Section One')
    puts "Section: #{s.name}"
    puts "Section Chart: #{s.chart.name}"
    puts "Section Lines: #{s.section_lines}"

    sl = s.section_lines.last
    puts "Section Line: #{sl.id}"
    puts "Section Line Section: #{sl.section.name}"

    t = sl.tool
    puts "Tool: #{t.name}"
    puts "Tool User Group: #{t.user_group}"

    ug = t.user_group
    puts "User Group: #{ug.name}"
    puts "User Group Users: #{ug.users}"
    puts "User Group Tools: #{ug.tools}"
    puts "User Group Users: #{ug.charts}"

    u = ug.users.find_by_email('dave@people.com');
    puts "User: #{u.email}"
    puts "User User Group: #{u.user_group}"

  end

end

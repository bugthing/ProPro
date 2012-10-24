require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
  fixtures :all

  test "user group fixtures" do

    u = UserGroup.find_by_name('User Group One')

    puts "User Group: #{u}"
    puts "User Group Charts: #{u.charts}"
    puts "User Group Tools: #{u.tools}"
    puts "User Group Users: #{u.users}"

    #c = u.charts.first.sections.first.section_lines.first.tool

    #puts "Chart: #{@chart.name}"
    #puts "Sections: #{@chart.sections}"
    #puts "Section Lines: #{@chart.sections.first.section_lines}"
    #puts "Section Line Tool: #{@chart.sections.first.section_lines.first.tool}"
    #puts "Tool User Group: #{@chart.sections.first.section_lines.first.tool.user_group}"
    #t = @chart.sections.first.section_lines.first.tool
    #puts ": #{Tool.find(t.id).user_group}"
    #puts ": #{}"
  end

  # test "the truth" do
  #   assert true
  # end
end

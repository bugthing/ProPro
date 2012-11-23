class SectionLine < ActiveRecord::Base
  belongs_to :tool
  belongs_to :section

  # start of the method that will build the tool (relative to this chart/section/sectionline)
  def section_line_tool
    plugin_name = tool.name.underscore
    class_name  = plugin_name.camelize
    return "** #{plugin_name} ** #{class_name} **"
  end

  def outgoing_sections
    # hack to return all sections except this lines one!
    section.chart.sections.reject { |s| s.id == section.id }.uniq
  end

end

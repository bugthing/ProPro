
class ProPro::Tool::PlainText < ProPro::Tool
end

class ProPro::Tool::InputBox < ProPro::Tool
end

class ProPro::Tool::NextButton < ProPro::Tool
  def onward_sections
    @section_line.section.chart.sections.reject { |s| s.id == @section_line.section.id }.uniq
  end
end

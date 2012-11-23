
class ProPro::Tool
  attr_reader :section_line
  attr_reader :ref

  attr_reader :onward_sections

  def initialize(section_line=nil)
    @section_line = (section_line.nil?) ? NullSectionLine.new() : section_line
  end

  # must return an Array
  def onward_sections
    []
  end

end

class NullSectionLine
end

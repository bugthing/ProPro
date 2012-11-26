
class ProPro::Tool
  attr_reader :section_line
  attr_reader :ref

  attr_reader :onward_sections

  def initialize(section_line=nil)
    @section_line = (section_line.nil?) ? NullSectionLine.new() : section_line
  end

  # The reference used for this tool
  # Curreny of no use.
  #   returns: String
  def ref
    self.class.name.underscore.sub('pro_pro/','')
  end

  # List of onward sections going out from this section_line
  # Intended to return an Array of Section objects
  #   returns: Array
  def onward_sections
    []
  end
  def has_onward_sections?
    onward_sections.size < 1 ? false : true
  end

  # String representing the HTML form that can be used to
  # edit this section line.
  #   returns: String
  def edit_html
    ''
  end

end

class NullSectionLine
end


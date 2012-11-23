
require 'pro_pro'
require 'pro_pro/tool'

# TBA: is there a nicer way to do this dynamic loading of tools?
dir = "#{File.dirname(__FILE__)}/../../lib/pro_pro/tool/*.rb"
Dir[ dir ].each { |f| require(f) }

class SectionLine < ActiveRecord::Base
  belongs_to :tool
  belongs_to :section

  # start of the method that will build the tool (relative to this chart/section/sectionline)
  def section_line_tool
    @section_line_tool ||= SectionLineTool.new(self, tool);
  end

  def outgoing_sections
    section_line_tool.onward_sections
  end

end

class SectionLineTool
  def initialize( section_line, tool )
    @section_line = section_line
    @tool         = tool
    @pro_tool     = tool_class.new(@section_line)
  end

  def onward_sections 
    @pro_tool.onward_sections
  end

  # get the tool class
  def tool_class
    plugin_name = @tool.name.gsub(/\s/, '_').downcase
    class_str = "ProPro::Tool::#{plugin_name.classify}"
    class_str.split('::').inject(Object) do |mod, class_name|
      mod.const_get(class_name)
    end
  end

end

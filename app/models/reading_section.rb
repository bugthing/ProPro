class ReadingSection < ActiveRecord::Base
  belongs_to :reading
  belongs_to :section
  attr_accessible :reading_id
  attr_accessible :section_id

  def read_html
    self.section.section_lines.inject('') do |str, section_line|
      tool = section_line.propro_tool( read_data_store )
      str += tool.read_html
    end
  end

  # FIXME - super crap! must move data store construction helper
  def read_data_store
    self.section.section_lines.first.data_store("reading_section_#{ self.id }")
  end

end

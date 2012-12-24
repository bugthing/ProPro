
class Reading < ActiveRecord::Base
  has_many :reading_lines
  has_one :current_reading_line, :class_name => ReadingLine
  belongs_to :chart

  attr_accessible :chart_id
  attr_accessible :current_reading_line_id

  after_initialize :add_default_reading_line

  validates :chart_id,  :presence => true

  def add_default_reading_line
    if self.new_record? and chart then 
      first_section = chart.sections.first;
      rl = ReadingLine.new( section_id: first_section.id )
      self.reading_lines << ReadingLine.new( section_id: first_section.id ) if self.new_record?
      update( :current_reading_line_id => rl.id )
    end
  end

  def current_html_output
    "<b> TO DO </b>"
  end

end

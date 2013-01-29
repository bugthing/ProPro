
class Reading < ActiveRecord::Base
  has_many :reading_sections
  has_one :current_reading_section, :class_name => ReadingSection
  has_one :current_section, :through => :current_reading_section, :source => :section
  belongs_to :chart

  attr_accessible :chart_id
  attr_accessible :current_reading_section_id

  after_initialize :add_default_reading_section

  validates :chart_id,  :presence => true

  def add_default_reading_section
    if self.new_record? and chart then 
      first_section = chart.sections.first;
      rl = ReadingSection.new( section_id: first_section.id )
      self.reading_sections << ReadingSection.new( section_id: first_section.id ) if self.new_record?
      current_reading_section_id = rl.id
      save!
    end
  end

  def current_html_output
    return "" unless current_reading_section # there should never be no current_reading_section!
    current_reading_section.section.section_lines.inject('') do |res, sl|
      res += sl.propro_tool.read_html
    end
  end

end


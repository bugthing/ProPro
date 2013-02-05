
class Reading < ActiveRecord::Base
  has_many :reading_sections
  #has_one :current_reading_section, :class_name => ReadingSection
  belongs_to :current_reading_section, :class_name => ReadingSection
  belongs_to :chart

  attr_accessible :chart_id
  attr_accessible :current_reading_section_id

  validates :chart_id,  :presence => true

  after_initialize :add_default_reading_section

  def add_default_reading_section
    if (self.new_record? and chart) then 
      reading_sections << ReadingSection.create( section_id: chart.sections.first.id )
      self.current_reading_section_id = self.reading_sections.first.id
    end
  end

end


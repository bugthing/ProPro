
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

  def submit_read_data( read_data )

    # set the read_data..
    data_store = current_reading_section.read_data_store
    data_store.clear
    read_data.each_pair do |k,v|
      data_store[k] = v
    end

    # move the current read section onward?..  
    current_reading_section.section.section_lines.each do |section_line|
      tool = section_line.propro_tool( data_store )
      if tool.has_onward_sections? and tool.onward_read_section_id
        new_reading_section = self.reading_sections.create( section_id: tool.onward_read_section_id )
        puts "BEFORE SET NEW READING SECTION: #{self.current_reading_section_id} -- #{new_reading_section.id}"
        self.current_reading_section_id = new_reading_section.id
        puts "CREATED AND SET NEW READING SECTION: #{self.current_reading_section_id} -- #{new_reading_section.id}"
        self.save
      end
    end

  end
end


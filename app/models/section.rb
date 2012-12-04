class Section < ActiveRecord::Base
  attr_accessible :name
  belongs_to :chart
  has_many :section_lines

  # return list of sections that go out from this section
  def outgoing_sections
    arr = []
    section_lines.each do |sl| 
      sl.outgoing_sections.each { |s| arr << s }
    end
    arr
  end

  # get all the other sections that belong to the parent chart
  # except this one (self)
  def sibling_sections
    self.chart.sections - [self]
  end

end

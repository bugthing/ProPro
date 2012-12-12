class Section < ActiveRecord::Base
  attr_accessible :name
  belongs_to :chart
  has_many :section_lines
  # get all the other sections that belong to the parent chart
  # except this one (self)
  def sibling_sections
    self.chart.sections - [self]
  end
end

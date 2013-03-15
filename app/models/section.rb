class Section < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :chart_id
  attr_accessible :pos_left
  attr_accessible :pos_top
  belongs_to :chart
  has_many :section_lines, :order => 'weight'

  # get all the other sections that belong to the parent chart
  # except this one (self)
  def sibling_sections
    self.chart.sections - [self]
  end

  # collection the read_html from each section_line's tool
  def read_html
    section_lines.map do |sl|
      sl.propro_tool.read_html
    end
  end

end

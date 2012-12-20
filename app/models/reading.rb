class Reading < ActiveRecord::Base
  has_many :reading_lines
  has_one :current_reading_line, :class_name => ReadingLine
  belongs_to :chart
  attr_accessible :chart_id
  attr_accessible :current_reading_line_id
end

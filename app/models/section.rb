class Section < ActiveRecord::Base
  attr_accessible :name
  belongs_to :chart
  has_many :section_lines
end

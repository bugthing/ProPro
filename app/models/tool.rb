class Tool < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user_group
  has_many :section_lines
end

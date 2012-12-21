
class SectionLine < ActiveRecord::Base
  belongs_to :tool
  belongs_to :section
  attr_accessible :tool_id
end

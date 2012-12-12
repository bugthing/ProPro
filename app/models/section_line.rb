
class SectionLine < ActiveRecord::Base
  attr_accessible :tool_id

  belongs_to :tool
  belongs_to :section
end

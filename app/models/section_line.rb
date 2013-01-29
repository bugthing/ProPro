
class SectionLine < ActiveRecord::Base
  include ProPro::SectionLineModelMixin
  belongs_to :tool
  belongs_to :section
  attr_accessible :tool_id
end


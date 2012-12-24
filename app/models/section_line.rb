
class SectionLine < ActiveRecord::Base
  include ProPro::ModelMixin
  belongs_to :tool
  belongs_to :section
  attr_accessible :tool_id
end



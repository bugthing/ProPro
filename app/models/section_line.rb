
class SectionLine < ActiveRecord::Base
  include ProPro::SectionLineModelMixin
  belongs_to :tool
  belongs_to :section
  attr_accessible :tool_id, :weight

  after_initialize :apply_weight_new_section_line

  def apply_weight_new_section_line
    if (self.new_record? and self.section and ! self.weight )
      self.weight = self.section.section_lines.maximum(:weight)
    end
  end

end


class SectionLine < ActiveRecord::Base
  belongs_to :tool
  belongs_to :section
end

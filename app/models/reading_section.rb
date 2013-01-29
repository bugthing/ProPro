class ReadingSection < ActiveRecord::Base
  include ProPro::ReadingSectionModelMixin
  belongs_to :reading
  belongs_to :section
  attr_accessible :reading_id
  attr_accessible :section_id
end

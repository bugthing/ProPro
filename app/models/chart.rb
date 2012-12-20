class Chart < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user_group

  has_many :sections, :order => 'created_at'
  has_many :readings
 
  validates :name,  :presence => true

  after_initialize :add_default_sections

  def add_default_sections
    self.sections << Section.new(name:"Section One") if self.new_record?
  end

end

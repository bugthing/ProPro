class Chart < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user_group

  has_many :sections, :order => 'created_at'
 
  validates :name,  :presence => true

  after_initialize :add_default_sections

  def add_default_sections
    self.sections << Section.new(name:"Section One") if self.new_record?
  end

  def sections_connections
    sections.each_with_object([]) do |sec, arr|
      sec.outgoing_sections.each { |out_sec| arr << [sec.id, out_sec.id] }
    end
  end

end

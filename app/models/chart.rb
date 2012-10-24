class Chart < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user_group

  has_many :sections
 
  validates :name,  :presence => true

end

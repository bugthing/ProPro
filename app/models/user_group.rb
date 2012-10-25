class UserGroup < ActiveRecord::Base
  attr_accessible :name
  has_many :users
  has_many :charts
  has_many :tools
end
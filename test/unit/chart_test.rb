require 'test_helper'

class ChartTest < ActiveSupport::TestCase
  should have_many(:sections)
  should have_many(:readings)
  should belong_to( :user_group )
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)
end

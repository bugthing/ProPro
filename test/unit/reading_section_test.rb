require 'test_helper'

class ReadingSectionTest < ActiveSupport::TestCase
  should belong_to(:reading)
  should belong_to(:section)
end

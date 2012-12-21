require 'test_helper'

class ReadingLineTest < ActiveSupport::TestCase
  should belong_to(:reading)
  should belong_to(:section)
end

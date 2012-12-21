require 'test_helper'

class SectionLineTest < ActiveSupport::TestCase
  should belong_to(:tool)
  should belong_to(:section)
end

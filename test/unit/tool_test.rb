require 'test_helper'

class ToolTest < ActiveSupport::TestCase
  should have_many(:section_lines)
  should  belong_to(:user_group)
end

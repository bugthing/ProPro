require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
  should have_many(:users)
  should have_many(:charts)
  should have_many(:tools)
  should have_many(:sections).through(:charts)
end

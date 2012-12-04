require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
  fixtures :all

  test "user group fixtures" do
    @user_group = UserGroup.find_by_name('User Group One')
    assert_equal "Chart One", @user_group.charts.first.name
    assert_equal ['Section One','Section Three','Section Two'], @user_group.sections.collect { |s| s.name }.sort
  end

end

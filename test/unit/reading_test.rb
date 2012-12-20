
require 'test_helper'

class ReadingTest < ActiveSupport::TestCase
  should belong_to(:chart)
  should have_many(:reading_lines)
  should have_one(:current_reading_line)

  #fixtures :all

  #context "with a chart" do
  #  setup do
  #    @reading = Reading.all.first
  #  end
  #  assert @reading.should chart
  #end

end


require 'test_helper'

class ReadingTest < ActiveSupport::TestCase
  should belong_to(:chart)
  should have_many(:reading_lines)
  should have_one(:current_reading_line)
  should validate_presence_of(:chart_id)

  context "with a chart" do
    fixtures :all
    setup do
      @chart = Chart.all.first
      @start_section = @chart.sections.first
      @reading = Reading.create( :chart_id => @chart.id )
    end
    should "have default reading line" do
      assert_equal 1, @reading.reading_lines.size
    end
    should "have default current reading line" do
      assert @reading.current_reading_line
      assert_equal @start_section.id, @reading.current_reading_line.section.id
    end
  end

end

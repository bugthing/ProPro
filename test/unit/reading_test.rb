
require 'test_helper'

class ReadingTest < ActiveSupport::TestCase
  should belong_to(:chart)
  should have_many(:reading_sections)
  should have_one(:current_reading_section)
  should validate_presence_of(:chart_id)

  context "with a chart" do
    fixtures :all
    setup do
      @chart = Chart.all.first
      @start_section = @chart.sections.first
      @reading = Reading.create( :chart_id => @chart.id )
    end
    should "have default reading line" do
      assert_equal 1, @reading.reading_sections.size
    end
    should "have default current reading line" do
      assert @reading.current_reading_section
      assert_equal @start_section.id, @reading.current_reading_section.section.id
    end
  end

end

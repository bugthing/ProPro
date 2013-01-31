require 'test_helper'

class ReadingsControllerTest < ActionController::TestCase
  fixtures :all

  context "with a chart id" do
    context "create a reading" do
      setup do
        @chart_id = Chart.all.first.id
        post :create, :reading => { :chart_id => @chart_id }
      end
      should assign_to(:reading)
      should "create the record" do
        assert Reading.find_by_chart_id( @chart_id )
      end
    end
  end

  context "with a reading id" do
    setup do
      @reading = Reading.all.first
    end
    context "load a reading" do
      setup do
        get :show, { id: @reading.id }
      end
      should assign_to(:reading)
    end
  end
end

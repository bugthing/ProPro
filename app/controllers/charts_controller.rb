class ChartsController < ApplicationController
  before_filter(:require_login)
 
  respond_to :html, :json, :xml
    
  def index
    respond_with charts
  end

  def show
    respond_with chart
  end

  def create
    chart.save
    respond_with chart
  end

  def update
    chart.update_attributes(params[:chart])
    respond_with chart
  end

  def destroy
    chart.destroy
    respond_with chart
  end
  
  private
  
  # Make these helpers available to the view too
  helper_method :chart, :charts
  
  def chart
    # If the action is new or create...
    @chart ||= if params[:action] =~ /new|create/
      Chart.new(params[:chart])
    else
      Chart.find(params[:id])
    end
  end

  def charts
    @charts = Chart.all
  end

end

class ChartsController < ApplicationController
  before_filter(:require_login)
 
  respond_to :html, :json, :xml
    
  def index
    respond_with charts, :except => [ :created_at, :updated_at ]
  end

  def show
    respond_with chart, :include => [ :sections ]
  end

  def create
    chart.save
    hash = { :chart => chart }
    respond_with hash, :location => "chart/#{chart.id}"
  end

  def update
    chart.update_attributes(params[:chart])
    hash = { :chart => chart }
    respond_with hash, :location => "chart/#{chart.id}"
  end

  def destroy
    chart.destroy
    respond_with chart, :except => [ :created_at, :updated_at ]
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

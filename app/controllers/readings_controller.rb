class ReadingsController < ApplicationController
 
  respond_to :html, :json
    
  def index
    @readings = Reading.all
    render "index"
  end

  def show
    @reading = Reading.find(params[:id])
    render "show"
  end

  def create
    @reading = Reading.new(params[:reading])
    @reading.save
    render "show", status: :created
  end

  def update
    @reading = Reading.find(params[:id])
    @reading.update_attributes(params[:reading])
    @chart.save
    render "show"
  end

  def destroy
    @reading = Reading.find(params[:id])
    @reading.destroy
    render json: nil, status: :ok
  end

end

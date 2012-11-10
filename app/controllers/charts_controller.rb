class ChartsController < ApplicationController
  before_filter(:require_login)
 
  respond_to :html, :json
    
  def index
    @charts = Chart.all
    render "index"
  end

  def show
    @chart = Chart.find(params[:id])
    render "show"
  end

  def create
    @chart = Chart.new(params[:chart])
    @chart.save
    render "show"
  end

  def update
    @chart = Chart.find(params[:id])
    @chart.update_attributes(params[:chart])
    @chart.save
    render "show"
  end

  def destroy
    @chart = Chart.find(params[:id])
    @chart.destroy
    render json: nil, status: :ok
  end
  
end

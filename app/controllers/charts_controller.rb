class ChartsController < ApplicationController
  before_filter(:require_login)
 
  respond_to :html, :json
    
  def index
    @charts = @current_user.user_group.charts.all
    render "index"
  end

  def show
    @chart = @current_user.user_group.charts.find(params[:id])
    render "show"
  end

  def create
    @chart = @current_user.user_group.charts.new(params[:chart])
    @chart.save
    render "show", status: :created
  end

  def update
    @chart = @current_user.user_group.charts.find(params[:id])
    @chart.update_attributes(params[:chart])
    @chart.save
    render "show"
  end

  def destroy
    @chart = @current_user.user_group.charts.find(params[:id])
    @chart.destroy
    render json: nil, status: :ok
  end
  
end

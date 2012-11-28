class BuilderController < ApplicationController
  before_filter(:require_login)

  def index
  end

  def show
    @chart = Chart.find(params[:id])
  end

end

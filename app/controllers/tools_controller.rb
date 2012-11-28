class ToolsController < ApplicationController
  before_filter(:require_login)

  respond_to :html, :json

  def index
    @tools = Tool.all
    render "index"
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

end

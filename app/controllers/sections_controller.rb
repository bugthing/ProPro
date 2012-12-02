class SectionsController < ApplicationController
  before_filter(:require_login)

  respond_to :html, :json

  def index
    @sections = Section.all
    render "index"
  end

  def show
    @section = Section.find(params[:id])
    @tools = Tool.all
    respond_with do |format|
      format.html { render "show", :layout => false }
      format.json { render "show" }
    end
  end

  def create
  end

  def update
  end

  def destroy
  end

end

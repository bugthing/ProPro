class SectionLinesController < ApplicationController
  before_filter(:require_login)

  respond_to :html, :json

  def index
    @section_lines = SectionLine.all
    render "index"
  end

  def show
    @section_line = SectionLine.find(params[:id])
    render "show"
  end

  def create
  end

  def update
  end

  def destroy
  end

end

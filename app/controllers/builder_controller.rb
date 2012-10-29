class BuilderController < ApplicationController
  before_filter(:require_login)

  def index
  end

  #def charts
  #  @charts = Chart.all
  #end
  #def chart
  #  @chart = Chart.find params[:id]
  #end
  #def sections
  #  @sections = Section.all
  #end
  #def section
  #  @section = Section.find params[:id]
  #end
  #def section_lines
  #  @section_lines = SectionLine.all
  #end
  #def section_line
  #  @section_line = SectionLine.find params[:id]
  #end

end

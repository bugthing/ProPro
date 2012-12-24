class BuilderController < ApplicationController

  before_filter(:require_login)

  def index
  end

  def show
    @chart = Chart.find(params[:id])
    @sections_connections = sections_connections
  end

  def connections
    @chart = Chart.find(params[:id])
    @sections_connections = sections_connections
  end

  private

  def sections_connections
    @chart.sections.each_with_object([]) do |sec, arr|
      sec.section_lines.map { |sl|
        #pt = propro_tool(sl)
        pt = sl.propro_tool
        pt.onward_section_ids.each { |out_sec_id| arr << [sec.id, out_sec_id] }
      }
    end
  end

end

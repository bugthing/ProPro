class BuilderController < ApplicationController
  include ProPro::ControllerMixin

  before_filter(:require_login)

  def index
  end

  def show
    @chart = Chart.find(params[:id])
    @sections_connections = sections_connections
  end

  private

  def sections_connections
    @chart.sections.each_with_object([]) do |sec, arr|
      sec.section_lines.map { |sl|
        pt = propro_tool(sl)
        pt.onward_sections.each { |out_sec| arr << [sec.id, out_sec.id] }
      }
    end
  end

end

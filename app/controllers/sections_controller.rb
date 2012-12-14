class SectionsController < ApplicationController
  include ProPro::ControllerMixin
  before_filter(:require_login)

  respond_to :html, :json

  def index
    @sections = Section.all
    render "index"
  end

  def show
    @section = Section.find(params[:id])
    @section_line_tools = section_line_tools
    respond_with do |format|
      format.html { render "show", :layout => false }
      format.json { render "show" }
    end
  end

  def create
  end

  def update
    @section = Section.find(params[:id])

    # TBA- Add tests for this!
    # process the params to pull out and submit section line
    # data to each propro tool (section line tool)
    section_line_tools.each do |propro_tool|

      section_line_id = propro_tool.adapter.section_line.id
      data = {}

      params.each do |fname, fdata|
        match_data = /^(?<name>.+?)_(?<id>\d+)$/.match( fname )
        if ( match_data && section_line_id.to_s == match_data[:id].to_s ) then
          data[ match_data[:name].to_sym ] = fdata
        end
      end

      propro_tool.adapter.edit_data = data 
    end

    @section_line_tools = section_line_tools

    respond_with do |format|
      format.html { render "show", :layout => false }
      format.json { render "show" }
    end
  end

  private

  def section_line_tools
    @section.section_lines.map { |sl| propro_tool(sl) }
  end

end

class SectionLinesController < ApplicationController

  before_filter(:require_login)

  respond_to :html, :json

  def index
    @section_lines = SectionLine.all
    render "index"
  end

  def show
    @section_line = SectionLine.find(params[:id])
    show_section_line
  end

  def create
    section = @current_user.user_group.sections.find(params[:section_id])
    @section_line = section.section_lines.new( tool_id: params[:tool_id] )
    @section_line.save
    show_section_line
  end

  def update
    @section_line = SectionLine.find(params[:id])
    # Here we deal with section_line weight data (if we got some)
    [:weight].each do |attr|
      next unless params[attr]
      @section_line.weight = params[attr]
      @section_line.save
    end
    show_section_line
  end

  def destroy
    @section_line = SectionLine.find(params[:id])
    @section_line.destroy
    render json: nil, status: :ok
  end

  private

  def show_section_line
    @section_line_tool = @section_line.propro_tool
    respond_with do |format|
      format.html { render "show", :layout => false }
      format.json { render "show" }
    end
  end

end

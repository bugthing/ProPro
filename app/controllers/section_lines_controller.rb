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

    # this should update the weight property on the model:
    @section_line.update_attributes(params[:section_line])

    # now lets get all params we dont expect ..
    data = params.except(:utf8,:_method,:authenticity_token,:section_line,:action,:controller,:id)
    # ..and save as edit data in the propro tool..
    @section_line.propro_tool.edit_data.clear
    data.each_pair { |k,v| @section_line.propro_tool.edit_data[k] = v }

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

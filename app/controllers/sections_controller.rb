class SectionsController < ApplicationController
  before_filter(:require_login)

  respond_to :html, :json

  def index
    @sections = Section.all
    render "index"
  end

  def show
    @section = Section.find(params[:id])
    respond_with do |format|
      format.html { render "show", :layout => false }
      format.json { render "show" }
    end
  end

  def create
    sec = { chart_id:params[:chart_id], name:params[:name] }
    @section = Section.create( sec )

    # TBA - Add tests for this!
    # look out for the 'from_section_id', if we get one, lets look up the section
    # and add a tool line which we will then link to this new @section.
    if ( params[:from_section_id] ) then
      # Onward Section - add section line to link to this new section from the
      # section with the matching id - TBA
      # .. get from section obj..
      from_section = Section.find(params[:from_section_id])
      # .. create a new section line based NextButton tool..
      new_section_line = from_section.section_lines.create({ :tool_id => Tool.find_by_name('Next Button').id })
      # .. get propro tool object..
      tool = new_section_line.propro_tool
      # .. set edit data..
      tool.edit_data['onward_section_id'] = @section.id
    end

    respond_with do |format|
      format.html { render "create", :layout => false }
      format.json { render "create" }
    end
  end

  def update
    @section = Section.find(params[:id])

    # this should update the name, pos_left, pos_top property on the model:
    @section.update_attributes(params[:section])

    respond_with do |format|
      format.html { render "show", :layout => false }
      format.json { render "show" }
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.delete

    # TBA - remove all section lines +tools (perhaps any subsections!?)
    render "show" # for now just render the show tpl
  end

end

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
      # .. get edit data..
      tool.edit_data['onward_section_id'] = @section.id
    end

    respond_with do |format|
      format.html { render "create", :layout => false }
      format.json { render "create" }
    end
  end

  def update
    @section = Section.find(params[:id])

    # TBA- Add tests for this!
    # process the params to pull out and submit section line
    # data to each propro tool (section line tool)
    @section.section_lines.each do |section_line|

      section_line_id = section_line.id
      data = {}

      params.each do |fname, fdata|
        match_data = /^(?<name>.+?)_(?<id>\d+)$/.match( fname )
        if ( match_data && section_line_id.to_s == match_data[:id].to_s ) then
          data[ match_data[:name] ] = fdata
        end
      end

      if ( data.keys.size > 0 )
        section_line.propro_tool.edit_data.clear
        data.each_pair { |k,v| section_line.propro_tool.edit_data[k] = v }
      end

    end

    # Here we deal with sections possitional data (if we got some)
    [:pos_left,:pos_top].each do |attr|
      @section.send(attr.to_s+'=', params[attr].to_i) unless ( params[attr].nil? )
      @section.save
    end

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

  private

  # TBA - move complexity into simple private methods
  def extract_hashes_of_section_line_data
  end
  def submit_each_section_lines_data
  end
  def create_onward_section_line
  end

end

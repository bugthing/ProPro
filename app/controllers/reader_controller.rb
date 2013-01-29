class ReaderController < ApplicationController

  before_filter :load_or_create_reading

  def show
  end

  def update
    # TBA- Add tests for this! 
    # process the params to pull out and submit section line
    # data to each propro tool (section line tool)
    # (need to extracted into method as is pretty much same as other method in section_controller!)
    next_section = nil
    @reading.current_section.section_lines.each do |sl|
      section_line_id = sl.id
      propro_tool = sl.propro_tool

      data = {}
      params.each do |fname, fdata|
        match_data = /^(?<name>.+?)_(?<id>\d+)$/.match( fname )
        if ( match_data && section_line_id.to_s == match_data[:id].to_s ) then
          data[ match_data[:name] ] = fdata
        end
      end
      propro_tool.adapter.read_data = data if ( data.keys.size > 0 )

      # here we ask the tool if it can give the next section
      # .. if so, lets update Reading to have a new ReadingSection
      if ( propro_tool.has_onward_sections? and propro_tool.onward_read_section_id ) then
        rs = ReadingSection.new( section_id: propro_tool.onward_read_section_id )
        @reading.reading_sections << rs
        @reading.current_reading_section_id  = rs.id
        @reading.save!
      end
    end
    render 'show'
  end

  def load_or_create_reading
    @reading = if params[:id] and params[:id] != '0' then
      Reading.find params[:id] 
    elsif params[:chart_id]
      Reading.create :chart_id => params[:chart_id]
    end
    throw "can load or create reading!!" unless @reading
  end

end

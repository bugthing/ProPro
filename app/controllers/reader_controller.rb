
class ReaderController < ApplicationController

  before_filter :load_or_create_reading

  def show
  end

  def update
    # TODO - this is shit! .. fix it!
    #
    # process the params to pull out and submit section line
    # data to each propro tool (section line tool)
    next_section = nil
    read_data_store = @reading.current_reading_section.read_data_store
    read_data_store.clear
    params.except(:controller, :action).each do |fname, fdata|
      read_data_store[ fname ] = fdata
    end

    @reading.current_reading_section.section.section_lines.each do |section_line|

      propro_tool = section_line.propro_tool( read_data_store )
      # here we ask the tool if it can give the next section
      # .. if so, lets update Reading to have a new ReadingSection
      if ( propro_tool.has_onward_sections? and propro_tool.onward_read_section_id ) then
        rs = ReadingSection.new( section_id: propro_tool.onward_read_section_id )
        @reading.reading_sections << rs
        @reading.current_reading_section_id  = rs.id
        @reading.save!
        @reading.reload
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


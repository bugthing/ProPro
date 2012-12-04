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
  end

  def update
    @section = Section.find(params[:id])

    # TBA- Add tests for this!
    # process the params to pull out and submit section line
    # data to each section line
    @section.section_lines.each do |section|

      data = {}

      params.each_pairs do |fname, fdata|
        if ( section.id == fname[/_(\d+)$/] ) then
          data[ fname[/^(.+?)_/] ] = fdata
        end
      end

      section.edit_data( data )
    end
  end

  def destroy
  end

end

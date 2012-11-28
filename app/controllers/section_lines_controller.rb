class SectionLinesController < ApplicationController
  before_filter(:require_login)

  respond_to :html, :json

  def index
    @section_lines = SectionLine.all
    render "index"
  end

  def show
    @section_line = SectionLine.find(params[:id])
    render "show"
  end

  def create
    section = @current_user.user_group.charts.find(params[:chart_id]).sections.find(params[:section_id])
    @section_line = section.section_lines.new( tool_id: params[:tool_id] )
    @section_line.save
    render "show", status: :created
  end

  def update
  end

  def destroy
    @section_line = SectionLine.find(params[:id])
    @section_line.destroy
    render json: nil, status: :ok
  end

end

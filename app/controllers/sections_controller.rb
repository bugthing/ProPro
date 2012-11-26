class SectionsController < ApplicationController
  before_filter(:require_login)

  respond_to :html, :json

  def index
    @sections = Section.all
    render "index"
  end

  def show
    @section = Section.find(params[:id])
    render "show"
  end

  def create
  end

  def update
  end

  def destroy
  end

end

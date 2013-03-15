
require 'sinatra/base'
require 'sinatra/r18n'
require "sinatra/config_file"

class MedPro < Sinatra::Base
  register Sinatra::R18n
  register Sinatra::ConfigFile

  config_file 'config.yml'

  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "public") }

  before do
    @propro = ProPro.new( settings.chart_api, settings.chart_api_key )
  end

  get '/' do
    @charts = @propro.list_charts
    @readings = @propro.list_readings
    erb :'index'
  end

  get '/newreading/:chart_id' do
    reading_id = @propro.start_reading( params[:chart_id] )
    redirect "/#{reading_id}"
  end

  get '/:reading_id' do
    @reading = @propro.show_reading( params[:reading_id] )
    erb :'reading'
  end
  post '/:reading_id' do
    # clean up params before we pass it on 
    rid = params.delete("reading_id")
    params.delete("splat")
    params.delete("captures")

    reading_id = @propro.update_reading( rid, params )
    redirect "/#{reading_id}"
  end

end

require 'rest_client'
require 'json'

class ProPro
  attr_reader :site, :api_key
  def initialize( url, key )
    @api_key = key
    @site = RestClient::Resource.new( url )
  end

  def list_charts
    response = site['api/charts'].get params:{api_key:api_key}
    list = JSON.parse response
    list['charts']
  end

  def list_readings
    response = site['api/readings'].get params:{api_key:api_key}
    list = JSON.parse response
    list['readings']
  end

  def start_reading( chart_id )
    response = site['api/readings'].post( {api_key:api_key, chart_id:chart_id} )
    reading = JSON.parse response
    reading['id']
  end

  def update_reading( reading_id, params )
    response = site["api/readings/#{reading_id}"].put( {api_key:api_key }.merge(params) )
    reading = JSON.parse response
    reading['id']
  end

  def show_reading( reading_id )
    response = site["api/readings/#{reading_id}"].get params:{api_key:api_key}
    reading = JSON.parse response
    reading
  end
end


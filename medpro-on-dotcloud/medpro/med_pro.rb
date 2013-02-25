require 'sinatra/base'
require 'sinatra/r18n'
require "sinatra/config_file"
require 'rest_client'
require 'json'

class MedPro < Sinatra::Base
  register Sinatra::R18n
  register Sinatra::ConfigFile

  config_file 'config.yml'

  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "public") }


  get '/' do

    #RestClient.add_before_execution_proc do |req, params|
    #  puts "SHITTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT: #{req.query} --> #{params}"
    #end
    
    @site = RestClient::Resource.new( settings.chart_api )

    response = @site['api/charts'].get params:{api_key:settings.chart_api_key}
    charts_list = JSON.parse response
    @charts = charts_list['charts']

    erb :'index'
  end

end

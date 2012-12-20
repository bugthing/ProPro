
# load yaml file.. parse it with ERB.. parse it with YAML.. set the constant..
require 'erb'
require 'pro_pro'
PROPRO_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/propro.yml" )).result)[Rails.env]




require 'pro_pro'

# load the yaml based configuration (1 config per enviroment)
PROPRO_CONFIG = YAML.load_file("#{Rails.root}/config/propro.yml")[Rails.env]



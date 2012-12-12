=begin

=end

module ProPro

  require 'pro_pro/tool'
  require 'pro_pro/adapter'
  require 'pro_pro/controller_mixin'
  
  # TBA: is there a nicer way to do this dynamic loading of tools?
  dir = "#{File.dirname(__FILE__)}/pro_pro/tool/*.rb"
  Dir[ dir ].each { |f| require(f) }

end



=begin

This mixin bridges the gap bettwen the Rails app (that exposes the processes)
and the code that actually executes the ProPro processes.

=end

module ProPro::ModelMixin

  def propro_tool
    tool_name = self.tool.name
    propro_tool = tool_class( tool_name ).new( propro_adapter() )
  end

  private

  # get the tool class (eg. ProPro::Tool::NextButton)
  def tool_class( tool_name )
    plugin_name = tool_name.gsub(/\s/, '_').downcase
    class_str = "ProPro::Tool::#{plugin_name.classify}"
    class_str.split('::').inject(Object) do |mod, class_name|
      mod.const_get(class_name)
    end
  end

  def propro_adapter
    propro_adapter = if ( PROPRO_CONFIG['adapter'] == 'yaml' )
      ProPro::SectionAdapter::Yaml.new( self, PROPRO_CONFIG['db_dir_path'] )
    elsif ( PROPRO_CONFIG['adapter'] == 'mongodb' )
      ProPro::SectionAdapter::MongoDB.new( self,
                                          PROPRO_CONFIG['mdb_host'], 
                                          PROPRO_CONFIG['mdb_port'], 
                                          PROPRO_CONFIG['mdb_dbname'], 
                                          PROPRO_CONFIG['mdb_user'], 
                                          PROPRO_CONFIG['mdb_pass'] )
    else
      ProPro::SectionAdapter.new( section_line )
    end
  end

end

module ProPro::ControllerMixin

  def propro_tool( section_line )
    tool_name = section_line.tool.name
    propro_tool = tool_class( tool_name ).new( propro_adapter(section_line) )
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

  def propro_adapter( section_line )
    propro_adapter = if ( PROPRO_CONFIG['adapter'] == 'yaml' )
      ProPro::SectionAdapter::Yaml.new( section_line, PROPRO_CONFIG['db_dir_path'] )
    elsif ( PROPRO_CONFIG['adapter'] == 'mongodb' )
      ProPro::SectionAdapter::Mongo.new( section_line, PROPRO_CONFIG['mdb_host'], PROPRO_CONFIG['mdb_port'] )
    else
      ProPro::SectionAdapter.new( section_line )
    end
  end

end

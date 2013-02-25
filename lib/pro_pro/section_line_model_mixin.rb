
=begin

This mixin bridges the gap bettwen the Rails app (that exposes the processes)
and the code that actually executes the ProPro processes.

=end

module ProPro::SectionLineModelMixin

  def propro_tool( read_data = nil )
    tool_name = self.tool.name

    siblings = self.section.sibling_sections;
    edit_data = data_store("section_#{ self.id }")
    propro_tool = tool_class( tool_name ).new( self.id, siblings, edit_data, read_data )
  end

  def data_store( store_id  )

    propro_adapter = if ( PROPRO_CONFIG['adapter'] == 'yaml' )
      ProPro::DataStore::Yaml.new( store_id, { db_dir_path: PROPRO_CONFIG['db_dir_path'] } )
    elsif ( PROPRO_CONFIG['adapter'] == 'mongodb' )
      ProPro::DataStore::MongoDB.new( store_id, {
                                          mdb_host: PROPRO_CONFIG['mdb_host'], 
                                          mdb_port: PROPRO_CONFIG['mdb_port'], 
                                          mdb_name: PROPRO_CONFIG['mdb_name'], 
                                          mdb_user: PROPRO_CONFIG['mdb_user'], 
                                          mdb_pass: PROPRO_CONFIG['mdb_pass'] } )
    else
      ProPro::DataStore( store_id )
    end
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

end

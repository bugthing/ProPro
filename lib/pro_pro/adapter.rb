
class ProPro::SectionAdapter
  attr_reader :section_line

  def initialize( section_line )
    @section_line = section_line
    @hash_data_store = Hash.new
  end

  # returns a String unique to this section line with no spaces and lower case.
  # expected use: filenames, form inputs, etc.
  def section_line_ref
    section_line.id.to_s
  end
  def sibling_sections
    section_line.section.sibling_sections
  end
  def edit_data
    return @hash_data_store
  end
  def edit_data=( data )
    @hash_data_store = data
    return @hash_data_store
  end

end

require 'yaml'
class ProPro::SectionAdapter::Yaml < ProPro::SectionAdapter

  def initialize( section_line, db_dir_path )
    super( section_line )
    @yaml_file = File.join( db_dir_path, "section_line_#{section_line_ref}.yml" )
    # ensure the yaml file exits..
    self.edit_data={} unless File.exists?(@yaml_file)
  end

  # load data from yaml file..
  def edit_data
    data = File.open(@yaml_file, "r") do |file|
      YAML.load(file)
    end
    return data ? data : {}
  end
  # save data in yaml file..
  def edit_data=( data )
    File.open(@yaml_file, "w") {|file| file.puts( data.to_yaml) }
  end

end

require 'mongo'
class ProPro::SectionAdapter::MongoDB < ProPro::SectionAdapter
  include Mongo

  def initialize( section_line, host='localhost', port='27017', user=nil, pass=nil )
    super( section_line )
    @mongo = MongoClient.new(host, port)
    if ( user && pass ) then
      @mongo.add_auth(mongo_dbname, user, pass)
    end
  end

  # load data from yaml file..
  def edit_data
    return cleaned_mongo_obj if( mongo_obj_exists? )
    self.edit_data = mongo_selector # creates new (empty) mongo doc
    cleaned_mongo_obj
  end

  # save data in yaml file..
  def edit_data=( data )
    mongo_coll.update( mongo_selector, data.merge(mongo_selector), { :upsert => true } )
  end

  private

  def cleaned_mongo_obj
    obj = mongo_coll.find_one( mongo_selector )
    obj.delete_if{ |k,v| k == '_id' || k == 'section_line_ref' }
  end

  def mongo_obj_exists?
    mongo_coll.find_one( mongo_selector ) ? true : false
  end

  def mongo_coll
    db     = @mongo['propro']
    coll   = db[ mongo_dbname ]
    return coll
  end

  def mongo_dbname
    "section_lines"
  end

  def mongo_selector
    { 'section_line_ref' => section_line_ref }
  end

end

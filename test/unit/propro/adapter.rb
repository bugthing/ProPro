
require 'test_helper'
 
class TestProProSectionAdapter < ActiveSupport::TestCase

  context "with a section line" do
    setup do
      @section_line = stub("SectionLine")
      @section = stub("Section")
      @section.stubs(:sibling_sections).returns([])
      @section_line.stubs(:id).returns('123')
      @section_line.stubs(:section).returns( @section )
    end

    context "and base class for ProPro::SectionAdapter" do
      setup do
        @adapter = ProPro::SectionAdapter.new( @section_line )
      end

      should "have some API to use" do
        assert @adapter
        assert_equal '123', @adapter.section_line_ref
        assert_equal [], @adapter.sibling_sections
        assert @adapter.edit_data = { :some => 'data' }
        assert_equal( { :some => 'data' }, @adapter.edit_data )
        assert @adapter.read_data = { :some2 => 'data2' }
        assert_equal( { :some2 => 'data2' }, @adapter.read_data )
      end
    end

    context "and base class for ProPro::SectionAdapter::Yaml" do
      setup do
        db_dir_path = File.expand_path("#{__FILE__}/../../../../db")
        @db_file = "#{db_dir_path}/section_line_123.yml"
        File.delete(@db_file) if File.exists?(@db_file)
        @db_read_file = "#{db_dir_path}/section_read_line_123.yml"
        File.delete(@db_read_file) if File.exists?(@db_read_file)
        @adapter = ProPro::SectionAdapter::Yaml.new( @section_line, db_dir_path )
      end
      teardown do
        File.delete(@db_file) if File.exists?(@db_file)
        File.delete(@db_read_file) if File.exists?(@db_read_file)
      end

      should "be able to save edit data" do
        assert_equal( { }, @adapter.edit_data )
        assert @adapter.edit_data = { :some => 'data' }
        assert_equal( { :some => 'data' }, @adapter.edit_data )
      end

      should "be able to save read data" do
        assert_equal( { }, @adapter.read_data )
        assert @adapter.read_data = { :some => 'data' }
        assert_equal( { :some => 'data' }, @adapter.read_data )
      end
    end

    ### TBA!
    #context "and base class for ProPro::SectionAdapter::MongoDB" do
    #  setup do

    #    # Need to mock out the MongoDB stuff!
    #    #mongo = mock('Mongo')
    #    #mongo_client = mock('MongoClient')

    #    @adapter = ProPro::SectionAdapter::MongoDB.new( @section_line )
    #  end

    #  should "be able to save edit data" do
    #    assert_equal( { }, @adapter.edit_data )
    #    assert @adapter.edit_data = { 'some' => 'data' }
    #    assert_equal( { 'some' => 'data' }, @adapter.edit_data )
    #  end
    #
    #  should "be able to save read data" do
    #    assert_equal( { }, @adapter.read_data )
    #    assert @adapter.read_data = { 'some2' => 'data2' }
    #    assert_equal( { 'some2' => 'data2' }, @adapter.read_data )
    #  end

    #  context "load again" do
    #    setup do
    #      @adapter2 = ProPro::SectionAdapter::MongoDB.new( @section_line )
    #    end
    #    should "be able to save read data" do
    #      assert_equal( { 'some2' => 'data2' }, @adapter2.read_data )
    #    end
    #  end
    #end

  end

end

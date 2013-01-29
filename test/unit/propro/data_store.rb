
require 'test_helper'
 
class TestProProDataStore < ActiveSupport::TestCase

  context "with an id" do
    setup do
      @id = '321'
    end
    context "DataStore" do
      subject{ ProPro::DataStore.new( @id ) }

      should "set and get some data" do
        assert_equal 'data', subject['test'] = 'data'
        assert_equal 'data', subject['test']
      end
      should "set and clear some data" do
        assert_equal 'data', subject['test'] = 'data'
        subject.clear
        assert_equal nil, subject['test']
      end
    end
    context "DataStore::Yaml defaults" do
      setup{ @opts = nil }
      subject{ ProPro::DataStore::Yaml.new( @id, @opts ) }

      should("throw an error") { assert_raise(RuntimeError, "Could not find DB dir path") { subject } }
      context "with valid options" do
        setup { @opts = { db_dir_path: dir_path = File.expand_path("#{__FILE__}/../../../../db") } }
        teardown { File.delete(subject.yaml_file) if File.exists?(subject.yaml_file) }

        should("not throw an error") { assert_nothing_raised { subject } }
        should "set and get some data" do
          assert_equal 'data', subject['test'] = 'data'
          assert_equal 'data', subject['test']
        end
        should "set and clear some data" do
          assert_equal 'data', subject['test'] = 'data'
          subject.clear
          assert_equal nil, subject['test']
        end
      end
    end

    #context "and base class for ProPro::SectionAdapter" do
    #  setup do
    #    @adapter = ProPro::SectionAdapter.new( @section_line )
    #  end

    #  should "have some API to use" do
    #    assert @adapter
    #    assert_equal '123', @adapter.section_line_ref
    #    assert_equal [], @adapter.sibling_sections
    #    assert @adapter.edit_data = { :some => 'data' }
    #    assert_equal( { :some => 'data' }, @adapter.edit_data )
    #    assert @adapter.read_data = { :some2 => 'data2' }
    #    assert_equal( { :some2 => 'data2' }, @adapter.read_data )
    #  end
    #end

    #context "and base class for ProPro::SectionAdapter::Yaml" do
    #  setup do
    #    db_dir_path = File.expand_path("#{__FILE__}/../../../../db")
    #    @db_file = "#{db_dir_path}/section_line_123.yml"
    #    File.delete(@db_file) if File.exists?(@db_file)
    #    @db_read_file = "#{db_dir_path}/section_read_line_123.yml"
    #    File.delete(@db_read_file) if File.exists?(@db_read_file)
    #    @adapter = ProPro::SectionAdapter::Yaml.new( @section_line, db_dir_path )
    #  end
    #  teardown do
    #    File.delete(@db_file) if File.exists?(@db_file)
    #    File.delete(@db_read_file) if File.exists?(@db_read_file)
    #  end

    #  should "be able to save edit data" do
    #    assert_equal( { }, @adapter.edit_data )
    #    assert @adapter.edit_data = { :some => 'data' }
    #    assert_equal( { :some => 'data' }, @adapter.edit_data )
    #  end

    #  should "be able to save read data" do
    #    assert_equal( { }, @adapter.read_data )
    #    assert @adapter.read_data = { :some => 'data' }
    #    assert_equal( { :some => 'data' }, @adapter.read_data )
    #  end
    #end

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

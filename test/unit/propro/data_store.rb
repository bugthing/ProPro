
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

    #context "DataStore::MongoDB defaults" do
    #  setup{ @opts = { } }
    #  subject{ ProPro::DataStore::MongoDB.new( @id, @opts ) }

    #  should("throw an error") { assert_raise(RuntimeError, "Could not get MongoDB connection") { subject } }
    #  context "with valid options" do
    #    setup{ 
    #      @opts = {
    #        mdb_host:'localhost',
    #        mdb_port:27817,
    #        mdb_user:'testuser',
    #        mdb_pass:'testpass',
    #        mdb_name:'propro'
    #      }
    #    }
    #    should("not throw an error") { assert_nothing_raised { subject } }
    #    should "set and get some data" do
    #      assert_equal 'data', subject['test'] = 'data'
    #      assert_equal 'data', subject['test']
    #    end
    #    should "set and clear some data" do
    #      assert_equal 'data', subject['test'] = 'data'
    #      subject.clear
    #      assert_equal nil, subject['test']
    #    end
    #  end
    #end

  end

end

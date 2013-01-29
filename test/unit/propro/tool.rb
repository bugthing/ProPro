# yes yes, I know this is not really a unit test! .. I'll split it up and move it later!

require 'test_helper'
 
class TestProProTool < ActiveSupport::TestCase

  context "with a section" do
    setup do
      @section = 123
      @siblings = []
      @edit_data = {}
      @read_data = {}
    end
    should "be able to build the most basic tool" do tool = ProPro::Tool.new( @section, @siblings ) # assert it's API..
      assert tool.edit_html
      assert tool.read_html
      assert ! tool.has_onward_sections?
      assert_equal [], tool.onward_sections
    end
    context "building a PlainText tool" do
      subject{ ProPro::Tool::PlainText.new( @section, @siblings, @edit_data, @read_data ) }
      should "give some edit html" do
        assert_match %r|<textarea  placeholder='' name='text_123'></textarea>|, subject.edit_html
      end
      should "give some read html" do
        assert_equal "", subject.read_html
      end
      context "with configured data" do
        setup { @edit_data['text'] = 'Some lovely text' }
        should "give some populated edit html" do
          assert_match %r|<textarea  placeholder='' name='text_123'>Some lovely text</textarea>|, subject.edit_html
        end
        should "give some populated read html" do
          assert_equal "Some lovely text", subject.read_html
        end
      end
    end
    context "building a InputBox tool" do
      subject{ ProPro::Tool::InputBox.new( @section, @siblings, @edit_data, @read_data ) }
      should "give some edit html" do
        assert_match %r|<input placeholder='Label for this input box' type='text' name='data_label_123' value=''/>|, subject.edit_html
        assert_match %r|<input placeholder='Name of the data field' type='text' name='data_name_123' value=''/>|, subject.edit_html
      end
      should "give some read html" do
        assert_match %r|<label>ERROR!</label>|, subject.read_html
      end
      context "with configured data" do
        setup do
          @edit_data['data_label'] = 'Your data please'
          @edit_data['data_name'] = 'date_field1'
        end
        should "give some populated edit html" do
          assert_match %r|<input placeholder='Label for this input box' type='text' name='data_label_123' value='Your data please'/>|, subject.edit_html
          assert_match %r|<input placeholder='Name of the data field' type='text' name='data_name_123' value='date_field1'/>|, subject.edit_html
        end
        should "give some populated read html" do
          assert_match %r|<label>Your data please</label>|, subject.read_html
          assert_match %r|<input type='text' name='date_field1' value=''\/>|, subject.read_html
        end
        context "with data from a reading" do
          setup do
            @read_data['date_field1'] = 'Some input data from reading'
          end
          should "give some populated read html" do
            assert_match %r|<input type='text' name='date_field1' value='Some input data from reading'\/>|, subject.read_html
          end
        end
      end
    end
    context "building a NextButton tool" do
      subject{ ProPro::Tool::NextButton.new( @section, @siblings, @edit_data, @read_data ) }
      should "give some edit html" do
        assert_match %r|<input placeholder='Text on the button' type='text' name='button_text_123' value=''/>|, subject.edit_html
        assert_match %r|<select name='onward_section_id_123'></select>|, subject.edit_html
      end
      should "give some read error" do
        assert_equal 'ERROR!', subject.read_html
      end
      context "with siblings" do
        setup do
          [{name:'Sibling One',id:321},{name:'Sibling Two',id:456},{name:'Sibling Three',id:789}].each do |test_sibling|
            @siblings.push OpenStruct.new(test_sibling)
          end
        end
        should "have selectable html" do
          @siblings.each do |opt|
            assert_match %r|<option value='#{opt.id}' >#{opt.name}</option>|, subject.edit_html
          end
        end
        should "NOT give id of onward read section" do
          assert_equal nil, subject.onward_read_section_id
        end
        context "with configured data" do
          setup do
            @edit_data['button_text'] = 'Next Please!'
            @edit_data['onward_section_id'] = '456'
          end
          should "give some populated edit html" do
            assert_match %r|<input placeholder='Text on the button' type='text' name='button_text_123' value='Next Please!'/>|, subject.edit_html
            assert_match %r|<option value='456' selected=true>Sibling Two</option>|, subject.edit_html
          end
          should "give some populated read html" do
            assert_equal "<input type='submit' name='next_button' value='Next Please!' />", subject.read_html
          end
          should "have onward section id" do
            assert_equal [456], subject.onward_sections
          end
          context "with data from a reading" do
            setup do
              @read_data['next_button'] = 'Next Please!'
            end
            should "give some populated read html" do
              assert_equal "<input type='submit' name='next_button' value='Next Please!' />", subject.read_html
            end
            should "give id of onward section" do
              assert_equal '456', subject.onward_read_section_id
            end
          end
        end
      end
    end
  end

  #context "with some edit data" do
  #  setup do
  #    @edit_data = ProPro::EditData.new( 'section123' )
  #  end
  #  should "be able to build a tool" do
  #    tool = ProPro::Tool.new( @edit_data )
  #    assert tool.edit_html
  #  end
  #end

  #context "with a section line adapter" do
  #  setup do
  #    @section_line_adapter = stub("ProPro::SectionAdapter")
  #  end

  #  context "and base class for ProPro::Tool's" do
  #    setup do
  #      @tool = ProPro::Tool.new( @section_line_adapter )
  #    end

  #    should "have some API to use" do
  #      assert_equal [], @tool.onward_sections
  #      assert_equal false, @tool.has_onward_sections?
  #      assert_equal '', @tool.edit_html
  #    end
  #  end

  #  context "with a NextButton and a section line" do
  #    setup do
  #      @sib_section = stub("Section")
  #      @sib_section.stubs(:name).returns("Sibling Section")
  #      @sib_section.stubs(:id).returns(234)

  #      @section_line_adapter = stub("ProPro::SectionAdapter")
  #      @section_line_adapter.stubs(:section_line_ref).returns('234')
  #      @section_line_adapter.stubs(:sibling_sections).returns([@sib_section])
  #      @section_line_adapter.stubs(:edit_data).returns({ button_text:'Move On', onward_section_id:''})
  #      @section_line_adapter.stubs(:edit_data=).returns(true)

  #      @tool = ProPro::Tool::NextButton.new( @section_line_adapter )
  #    end

  #    should "have some html that gets saved and read" do
  #      assert_match /<option value='234' >Sibling Section/, @tool.edit_html
  #      @section_line_adapter.stubs(:edit_data).returns({ button_text:'Move On', onward_section_id:'234'})
  #      assert_match /<option value='234' selected>Sibling Section/, @tool.edit_html
  #    end

  #  end
  #end

end

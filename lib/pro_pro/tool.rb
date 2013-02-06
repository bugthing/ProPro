
# To be replaced with some gem .. but what?..
module ProPro::HtmlFormHelpers
  def input_name_for(base_name)
    base_name
  end
  def editor_value_for(base_name)
    edit_data[ base_name ]
  end

  def generate_edit_html_form( form_cfg )
    html_form = ""
    form_cfg.each_pair do |name, cfg|
        html_form += "
    <div>
      <label for='#{ input_name_for( name ) }'> #{ cfg[:label] } </label>
      <div class='controls'>
        "
        if ( cfg[:type] == :text )
            html_form += "<input placeholder='#{ cfg[:placeholder] }' type='text' name='#{ input_name_for( name ) }' value='#{ editor_value_for( name ) }'/>"
        elsif ( cfg[:type] == :textarea )
            html_form += "<textarea  placeholder='#{ cfg[:placeholder] }' name='#{ input_name_for( name ) }'>#{ editor_value_for( name ) }</textarea>"
        elsif ( cfg[:type] == :section_select )
            html_form += "<select name='#{ input_name_for( name ) }'>"
            selected_value = editor_value_for( name )
            all_other_sections.each do |section|
              html_form += "<option value='#{section.id}' #{ section.id == selected_value.to_i ? 'selected=true' : '' }>#{section.name}</option>"
            end
            html_form += "</select>"
        end

        html_form += "
      </div>
    </div>
        "
    end
    return html_form
  end

  def all_other_sections
    sibling_sections
  end
end

# base call for all tools 
class ProPro::Tool
  include ProPro::HtmlFormHelpers

  attr_reader :section_line
  attr_reader :sibling_sections
  attr_reader :edit_data
  attr_reader :read_data

  def initialize( section_line=0, sibling_sections=[], edit_data={}, read_data={} )
    @section_line = section_line          # ID of section_line
    @sibling_sections = sibling_sections  # Array of sibling section IDs (of the section_line parent section)
    @edit_data = edit_data                # Hash of edit data
    @read_data = read_data                # Hash of read data
  end

  # List of onward sections going out from this tool
  # Intended to return an Array of Section objects
  #   returns: Array
  def onward_sections
    []
  end
  def has_onward_sections?
    onward_sections.size < 1 ? false : true
  end

  # String representing the HTML form that can be used to
  # edit this tool.
  #   returns: String
  def edit_html
    ''
  end

  # String representing the HTML used when reading this tool
  #   returns: String
  def read_html
    ''
  end

end

class ProPro::Tool::PlainText < ProPro::Tool
  def edit_html
    generate_edit_html_form(
      'text' => {
        type: :textarea,
        label: "Text"
      }
    )
  end
  def read_html
    edit_data['text'] || ''
  end
end

class ProPro::Tool::InputBox < ProPro::Tool
  def edit_html
    generate_edit_html_form(
      'data_name' => {
        type: :text,
        label: "Data name",
        placeholder: "Name of the data field"
      },
      'data_label' => {
        type: :text,
        label: "Data Label",
        placeholder: "Label for this input box"
      },
    )
  end
  def read_html
    html = "<label>#{edit_data['data_label'] || 'ERROR!'}</label>"
    if ( edit_data['data_name'] ) then
      html += "<input type='text' name='#{edit_data['data_name']}' value='#{read_data[ edit_data['data_name'] ]}'/>"
    end
    return html
  end
end

class ProPro::Tool::NextButton < ProPro::Tool
  def onward_sections
    osi = edit_data[ 'onward_section_id' ]
    osi ? [ osi.to_i ] : []
  end
  def onward_read_section_id
    read_data['next_button'] ? edit_data['onward_section_id'] : nil
  end

  def edit_html
    generate_edit_html_form(
      'button_text' => {
        type: :text,
        label: "Button Text",
        placeholder: "Text on the button",
      },
      'onward_section_id' => {
        type: :section_select,
        label: "Onward Section",
      },
    )
  end
  def read_html
    edit_data['onward_section_id'] ? "<input type='submit' name='next_button' value='#{edit_data['button_text']}' />" : 'ERROR!'
  end
end



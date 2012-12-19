
# To be replaced with some gem .. but what?..
module ProPro::HtmlFormHelpers
  def editor_name_for(base_name)
    "#{base_name}_#{adapter.section_line_ref}"
  end
  def editor_value_for(base_name)
    ed = adapter.edit_data
    adapter.edit_data[ base_name ]
  end

  def generate_edit_html_form( form_cfg )
    html_form = ""
    form_cfg.each_pair do |name, cfg|
        html_form += "
    <div>
      <label for='#{ editor_name_for( name ) }'> #{ cfg[:label] } </label>
      <div class='controls'>
        "
        if ( cfg[:type] == :text )
            html_form += "<input placeholder='#{ cfg[:placeholder] }' type='text' name='#{ editor_name_for( name ) }' value='#{ editor_value_for( name ) }'/>"
        elsif ( cfg[:type] == :textarea )
            html_form += "<textarea  placeholder='#{ cfg[:placeholder] }' name='#{ editor_name_for( name ) }'>#{ editor_value_for( name ) }</textarea>"
        elsif ( cfg[:type] == :section_select )
            html_form += "<select name='#{ editor_name_for( name ) }'>"
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
    adapter.sibling_sections
  end
end

class ProPro::Tool
  include ProPro::HtmlFormHelpers

  attr_reader :adapter
  attr_reader :onward_section_ids

  def initialize( apt)
    # could validate passed in adaptor here (does it have correct api?)
    @adapter = apt
  end

  # List of onward sections going out from this section_line
  # Intended to return an Array of Section objects
  #   returns: Array
  def onward_section_ids
    []
  end
  def has_onward_sections?
    onward_section_ids.size < 1 ? false : true
  end

  # String representing the HTML form that can be used to
  # edit this tool.
  #   returns: String
  def edit_html
    ''
  end

end


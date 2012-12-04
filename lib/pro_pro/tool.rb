
# To be replaced with some gem .. but what?..
module ProPro::HtmlFormHelpers
  def editor_name_for(base_name)
    "#{base_name}_#{section_line.id}"
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
            html_form += "<input placeholder='#{ cfg[:placeholder] }' type='text' name='#{ editor_name_for( name ) }' />"
        elsif ( cfg[:type] == :textarea )
            html_form += "<textarea  placeholder='#{ cfg[:placeholder] }' name='#{ editor_name_for( name ) }'></textarea>"
        elsif ( cfg[:type] == :section_select )
            html_form += "<select name='#{ editor_name_for( name ) }'>"
            all_other_sections.each do |section|
                html_form += "<option value='#{section.id}'>#{section.name}</option>"
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
    @section_line.section.sibling_sections
  end
end

class ProPro::Tool
  include ProPro::HtmlFormHelpers

  attr_reader :section_line
  attr_reader :ref
  attr_reader :onward_sections

  def initialize(sl)
    @section_line = sl
  end

  # The reference used for this tool
  # Curreny of no use.
  #   returns: String
  def ref
    self.class.name.underscore.sub('pro_pro/','')
  end

  # List of onward sections going out from this section_line
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
  # Process the data for editing this tool, maybe validate and store inbound 
  # edit data, if something fails return false (TBA: think about error types here)
  #   returns: Boolean
  def edit_data( data )
    return false
  end

end


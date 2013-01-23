
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
    "<div>#{adapter.edit_data['text']}</div>"
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
    "<div>
        <label>#{adapter.edit_data['data_label']}</label>
        <input type='text' name='#{adapter.edit_data['data_name']}' value=''>
    </div>"
  end
end

class ProPro::Tool::NextButton < ProPro::Tool
  def onward_section_ids
    osi = adapter.edit_data[ 'onward_section_id' ]
    osi ? [ osi.to_i ] : []
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
    "<div>
        <input type='submit' name='#{adapter.edit_data['data_name']}' value='#{adapter.edit_data['button_text']}'>
    </div>"
  end
end

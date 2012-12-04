
class ProPro::Tool::PlainText < ProPro::Tool
  def edit_html
    generate_edit_html_form(
      text: {
        type: :textarea,
        label: "Text"
      }
    )
  end
end

class ProPro::Tool::InputBox < ProPro::Tool
  def edit_html
    generate_edit_html_form(
      data_name: {
        type: :text,
        label: "Data name",
        placeholder: "Name of the data field"
      },
      data_label: {
        type: :text,
        label: "Data Label",
        placeholder: "Label for this input box"
      },
    )
  end
end

class ProPro::Tool::NextButton < ProPro::Tool
  def onward_sections
    @section_line.section.sibling_sections
  end
  def edit_data( data )
    # TBA - validate and store inbound edit data (store it where?)
    return true
  end
  def edit_html
    generate_edit_html_form(
      button_text: {
        type: :text,
        label: "Button Text",
        placeholder: "Text on the button",
      },
      onward_section_id: {
        type: :section_select,
        label: "Onward Section",
      },
    )
  end
end

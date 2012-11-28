
class ProPro::Tool::PlainText < ProPro::Tool
  def edit_html
    '
    <table class="table">
      <thead>
        <tr>
          <th> Plain Text </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td> <textarea> </textarea> </td>
        </tr>
      </tbody>
    </table>
    '
  end
end

class ProPro::Tool::InputBox < ProPro::Tool
  def edit_html
    "
    <div>
      <label for='#{ editor_name_for("data_name") }'> Data name </label>
      <div class='controls'>
        <input placeholder='Name of data' type='text' name='#{ editor_name_for("data_name") }' />
      </div>
    </div>
    <div>
      <label for='#{ editor_name_for("data_label") }'> Data label </label>
      <div class='controls'>
        <input placeholder='Name of data' type='text' name='#{ editor_name_for("data_label") }' />
      </div>
    </div>
    "
  end
end

class ProPro::Tool::NextButton < ProPro::Tool
  def onward_sections
    @section_line.section.chart.sections.reject { |s| s.id == @section_line.section.id }.uniq
  end
  def edit_html
    '
    <table class="table">
      <thead>
        <tr>
          <th> Next Button </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td> <input type="text"> </td>
        </tr>
      </tbody>
    </table>
    '
  end
end

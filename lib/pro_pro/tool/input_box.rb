
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
    '
    <table class="table">
      <thead>
        <tr>
          <th> InputBox </th>
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

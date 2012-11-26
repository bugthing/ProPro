object @section
attributes :id, :name, :section_lines
node :section_lines do
    @section.section_lines.map { |sl| sl.id }
end


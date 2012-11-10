object @chart
attributes :id, :name, :sections
node :sections do
    @chart.sections.map { |sec| sec.id }
end


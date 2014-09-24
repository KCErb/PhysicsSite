module Plotter
  class CombinedPlot

    attr_reader :vis, :plots, :x_scale, :y_scale

    def initialize(plots = [], opts = {})
      @plots = plots
      @x_scale = opts[:x_scale] || plots[0].x_scale
      @y_scale = opts[:y_scale] || plots[0].y_scale
      edit_scales
      generate_vis
    end

    def edit_scales
      @plots.each do |plot|
        plot.x_scale = @x_scale
        plot.y_scale = @y_scale
        plot.generate_marks
      end
    end

    def generate_vis
      combined = self
      @vis = visualization.width(500).height(350) do
        padding top: 10, left: 50, bottom: 30, right: 10
        data *combined.plots.map{|plot| plot.data}
        scales combined.x_scale, combined.y_scale
        marks *combined.plots.map{|plot| plot.marks}
        axes x_axis.scale(combined.x_scale), y_axis.scale(combined.y_scale)
      end
    end
  end
end

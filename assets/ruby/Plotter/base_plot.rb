module Plotter
  class BasePlot

    attr_reader :data, :marks, :vis, :name, :opts
    attr_writer :x, :y
    attr_accessor :x_scale, :y_scale

    def initialize(x, y, opts = {})
      @x = x
      @y = y
      @opts = opts
      @name = ('a'..'z').to_a.shuffle[0,8].join
      generate_table
      generate_scales
      generate_marks
      generate_vis
    end

    def generate_table
      values_array = Array.new(@x.length)
      values_array.map!.with_index do |elem, index|
        {x: @x[index], y: @y[index]}
      end
      @data = Plotrb::Data.new.name(@name).values(values_array)
    end

    def generate_scales
      @x_scale = linear_scale.name("#{@name}-x-scale").from("#{@name}.x").to_width
      @y_scale = linear_scale.name("#{@name}-y-scale").from("#{@name}.y").to_height
    end

    def generate_vis
      plot = self
      @vis = visualization.width(500).height(350) do
        padding top: 10, left: 50, bottom: 30, right: 10
        data plot.data
        scales plot.x_scale, plot.y_scale
        marks plot.marks
        axes x_axis.scale(plot.x_scale), y_axis.scale(plot.y_scale)
      end
    end
  end
end

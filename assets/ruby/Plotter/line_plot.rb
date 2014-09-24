module Plotter
  class LinePlot < BasePlot
    def generate_marks
      plot = self
      @marks = line_mark.from(@data) do
        enter do
          x   { scale(plot.x_scale).from('x') }
          y   { scale(plot.y_scale).from('y') }
        end
        update do
          stroke plot.opts[:stroke] || 'black'
          stroke_width 2
        end
        hover do
          stroke 'darkred'
          stroke_width 3
        end
      end
    end
  end
end

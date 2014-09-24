module Plotter
  class BarPlot < BasePlot
    def generate_marks
      plot = self
      @marks = rect_mark.from(@data) do
        enter do
          x_start   { scale(plot.x_scale).from('x') }
          width     { scale(plot.x_scale).value(0.9)}
          y_start   { scale(plot.y_scale).from('y') }
          y_end     { scale(plot.y_scale).value(0) }
        end
        update do
          fill plot.opts[:fill] || 'steelblue'
        end
        hover do
          fill 'limegreen'
        end
      end
    end
  end
end

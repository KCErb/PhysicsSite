require_relative '../DIPTools/dip_tools.rb'
require_relative '../Plotter/plotter.rb'
include DIPTools

picture = NImage.new("images-3/CTscan.jpg")
pic_hist = picture.histogram(256) #generate hist before manipulations
x_values = (0..255).to_a

plot = Plotter::BarPlot.new(x_values, pic_hist.red)
json = plot.vis.generate_spec(:pretty)
File.open("json-3/CTscan-hist.json", 'w') { |file| file.write(json) }

pic_cdf = picture.cdf(256)
plot = Plotter::BarPlot.new(x_values, pic_cdf.red)
json = plot.vis.generate_spec(:pretty)
File.open("json-3/CTscan-cdf.json", 'w') { |file| file.write(json) }

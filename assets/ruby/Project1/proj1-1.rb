require_relative '../DIPTools/dip_tools.rb'
require_relative '../Plotter/plotter.rb'
include DIPTools

['chang','crowd','portal','university','notebook','baby'].each do |image_name|
  picture = NImage.new("images-1/" + image_name + ".tiff")
  pic_cdf = picture.cdf(256)
  x_values = (0..255).to_a
  plot = Plotter::BarPlot.new(x_values, pic_cdf.red)
  json = plot.vis.generate_spec(:pretty)
  File.open("json-1/#{image_name}-cdf.json", 'w') { |file| file.write(json) }
end

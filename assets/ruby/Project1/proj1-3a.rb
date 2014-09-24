require_relative '../DIPTools/dip_tools.rb'
require_relative '../Plotter/plotter.rb'
include DIPTools


THRESHOLDS = [128, 123]

['checker1','checker2'].each_with_index do |image_name, index|
  thresh = THRESHOLDS[index] # threshold of this image

  # Import Image, Calculate PDF and output plot with threshold overlaid
  picture = NImage.new("images-3/" + image_name + ".gif")
  pic_pdf = picture.pdf(256)
  x_values = (0..255).to_a
  pdf_plot = Plotter::BarPlot.new(x_values, pic_pdf.red)
  thresh_line = Plotter::BarPlot.new([thresh],[1.0], fill: 'magenta')
  combined = Plotter::CombinedPlot.new [pdf_plot, thresh_line]
  json = combined.vis.generate_spec(:pretty)
  File.open("json-3/#{image_name}-pdf.json", 'w') { |file| file.write(json) }

  # Threshold image and write file
  picture.threshold!(thresh)
  image_out = picture.to_image
  image_out.write("images-3/#{image_name}-th.png")
end

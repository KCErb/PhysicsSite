require_relative '../DIPTools/dip_tools.rb'
require_relative '../Plotter/plotter.rb'
include DIPTools

['chang','crowd','portal','university','notebook','baby'].each do |image_name|
  # Import Image, Calculate PDF, CDF and output plot
  picture = NImage.new("images-1/" + image_name + ".tiff")
  pic_pdf = picture.pdf(256)
  pic_cdf = picture.cdf(256)
  pic_pdf.rescale!(1.0) #scale pdf to max at 1 for simultaneous plot

  x_values = (0..255).to_a
  pdf_plot = Plotter::BarPlot.new(x_values, pic_pdf.red)
  cdf_plot = Plotter::LinePlot.new(x_values, pic_cdf.red)
  combined = Plotter::CombinedPlot.new [pdf_plot, cdf_plot]
  json = combined.vis.generate_spec(:pretty)
  File.open("json-2/#{image_name}-pdf-cdf.json", 'w') { |file| file.write(json) }

  # Equalize cdf, rescale image and write image
  pic_cdf.equalize!
  equalized_nimage = pic_cdf.back_to_nimage
  image_out = equalized_nimage.to_image
  image_out.write("images-2/#{image_name}-eq.png")

  # Find new PDF and CDF of rescaled image, output plot
  eq_pdf = equalized_nimage.pdf(256)
  eq_cdf = equalized_nimage.cdf(256)
  eq_pdf.rescale!(1.0)

  pdf_plot = Plotter::BarPlot.new(x_values,eq_pdf.red)
  cdf_plot = Plotter::LinePlot.new(x_values,eq_cdf.red)
  combined = Plotter::CombinedPlot.new [pdf_plot, cdf_plot]
  json = combined.vis.generate_spec(:pretty)
  File.open("json-2/#{image_name}-pdf-cdf-eq.json", 'w') { |file| file.write(json) }
end

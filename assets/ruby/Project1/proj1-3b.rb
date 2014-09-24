require_relative '../MathTools/math_tools.rb'
require_relative '../DIPTools/dip_tools.rb'
require_relative '../Plotter/plotter.rb'
include DIPTools


['checker1','checker2'].each_with_index do |image_name, index|
  picture = NImage.new("images-3/" + image_name + ".gif")

  # Select regions of interest
  coi = picture.red_channel #channel of interest
  dark_roi = coi[0..19, 0..19] #top left corner is dark region of interest
  light_roi = coi[0..19, -20..-1] #top right is light

  #flatten and calculate mean and std of each region
  flat_dark_roi = dark_roi.reshape(dark_roi.capacity) #flattens matrix
  dark_mean = flat_dark_roi.mean.to_f
  dark_std = flat_dark_roi.std.to_f

  flat_light_roi = light_roi.reshape(light_roi.capacity)
  light_mean = flat_light_roi.mean.to_f
  light_std = flat_light_roi.std.to_f

  #Create x and y values of function
  x_values = (0..255).to_a
  y_dark =  x_values.map{|x| MathTools.gauss(x, dark_mean, dark_std, dark_roi.capacity)}
  y_light = x_values.map{|x| MathTools.gauss(x, light_mean, light_std, light_roi.capacity)}

  # Convert roi to image for histogram analysis
  dark_roi_nimage = NImage.new(dark_roi)
  light_roi_nimage = NImage.new(light_roi)

  dark_pdf = dark_roi_nimage.histogram(256)
  light_pdf = light_roi_nimage.histogram(256)

  dark_pdf_plot = Plotter::BarPlot.new(x_values, dark_pdf.red)
  dark_gauss_plot = Plotter::LinePlot.new(x_values, y_dark)
  light_pdf_plot = Plotter::BarPlot.new(x_values, light_pdf.red)
  light_gauss_plot = Plotter::LinePlot.new(x_values, y_light)
  combined = Plotter::CombinedPlot.new [light_pdf_plot, light_gauss_plot, dark_pdf_plot, dark_gauss_plot]
  json = combined.vis.generate_spec(:pretty)
  File.open("json-3/#{image_name}-class-specific.json", 'w') { |file| file.write(json) }
end

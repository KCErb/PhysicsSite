require_relative '../MathTools/math_tools.rb'
require_relative '../DIPTools/dip_tools.rb'
require_relative '../Plotter/plotter.rb'
include DIPTools


['checker1','checker2'].each_with_index do |image_name, index|
  picture = NImage.new("images-3/" + image_name + ".gif")
  pic_hist = picture.histogram(256) #generate hist before manipulations

  # Select regions of interest
  coi = picture.red_channel #channel of interest
  light_roi = coi[0..19, 0..19]  #top left corner is light region of interest
  dark_roi = coi[0..19, -20..-1] #top right corner is dark region of interest

  #flatten and calculate mean and std of each region
  flat_dark_roi = dark_roi.reshape(dark_roi.capacity) #flattens matrix
  dark_mean = flat_dark_roi.mean.to_f
  dark_std = flat_dark_roi.std.to_f

  flat_light_roi = light_roi.reshape(light_roi.capacity)
  light_mean = flat_light_roi.mean.to_f
  light_std = flat_light_roi.std.to_f

  # Define normals to give relative intensities of each histogram.
  # I obtained these numbers visually. The pair 0.38, 0.62 means I estimate
  # Light regions to occupy 62% of the image in checker2
  norms = [[0.5,0.5],[0.38, 0.62]]
  n_dark = coi.capacity * norms[index][0]
  n_light = coi.capacity * norms[index][1]

  #Create x and y values of gaussian function
  x_values = (0..255).to_a
  y_dark =  x_values.map{|x| MathTools.gauss(x, dark_mean,  dark_std, n_dark) }
  y_light = x_values.map{|x| MathTools.gauss(x, light_mean, light_std, n_light)}
  y_total = y_dark.map.with_index{|y, index| y + y_light[index] } #add together the two arrays

  # This goes through groups of 3 and checks the neighbors to see if they are greater.
  # It's a very breakable way to find a local minimum. But it will find the minimum for
  # A simple monotonic function with only 1 minimum like the one we have here.
  threshold = 0
  y_total.each_cons(3) do |left,middle,right|
    threshold += 1
    break if middle < right && middle < left
  end

  # Threshold image and write file
  picture.threshold! threshold
  image_out = picture.to_image
  image_out.write("images-3/#{image_name}-th2.png")

  pdf_plot = Plotter::BarPlot.new(x_values, pic_hist.red)
  thresh_line = Plotter::BarPlot.new([threshold],[1000], fill: 'magenta')
  dark_gauss_plot = Plotter::LinePlot.new(x_values, y_dark)
  light_gauss_plot = Plotter::LinePlot.new(x_values, y_light)
  combined_gauss_plot = Plotter::LinePlot.new(x_values, y_total, stroke: 'limegreen')

  combined = Plotter::CombinedPlot.new [pdf_plot, thresh_line, light_gauss_plot, dark_gauss_plot, combined_gauss_plot]
  json = combined.vis.generate_spec(:pretty)
  File.open("json-3/#{image_name}-final.json", 'w') { |file| file.write(json) }
end

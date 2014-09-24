require_relative '../MathTools/math_tools.rb'
require_relative '../DIPTools/dip_tools.rb'
require_relative '../Plotter/plotter.rb'
include DIPTools

picture = NImage.new("images-3/CTscan.jpg")
pic_hist = picture.histogram(256) #generate hist before manipulations

# Select regions of interest
coi = picture.red_channel #channel of interest
bone_roi = coi[ 171..178, 105..120]
soft_roi = coi[148..158, 90..100]

#flatten and calculate mean and std of each region
flat_bone_roi = bone_roi.reshape(bone_roi.capacity) #flattens matrix
bone_mean = flat_bone_roi.mean.to_f
bone_std = flat_bone_roi.std.to_f

flat_soft_roi = soft_roi.reshape(soft_roi.capacity)
soft_mean = flat_soft_roi.mean.to_f
soft_std = flat_soft_roi.std.to_f

# Define normals to give relative intensities of each histogram.
n_bone = coi.capacity * 0.3
n_soft = coi.capacity * 0.15

thresh = 200 #determined experimentally

# Threshold image and write file
picture.threshold! thresh
image_out = picture.to_image
image_out.write("images-3/CTscan-th.png")

# Create Histogram with new threshold and gaussians overlaid

#Create x and y values of function
x_values = (0..255).to_a
y_bone =  x_values.map{|x| MathTools.gauss(x, bone_mean,  bone_std, n_bone) }
y_soft = x_values.map{|x| MathTools.gauss(x, soft_mean, soft_std, n_soft)}
y_total = y_bone.map.with_index{|y, index| y + y_soft[index] }

# Create each plot and combine them
pdf_plot = Plotter::BarPlot.new(x_values, pic_hist.red)
thresh_line = Plotter::BarPlot.new([thresh],[10000], fill: 'magenta')
bone_gauss_plot = Plotter::LinePlot.new(x_values, y_bone)
soft_gauss_plot = Plotter::LinePlot.new(x_values, y_soft)
combined_gauss_plot = Plotter::LinePlot.new(x_values, y_total, stroke: 'limegreen')

combined = Plotter::CombinedPlot.new [pdf_plot, thresh_line, soft_gauss_plot, bone_gauss_plot, combined_gauss_plot]

# Write out to json file
json = combined.vis.generate_spec(:pretty)
File.open("json-3/CTscan-final.json", 'w') { |file| file.write(json) }

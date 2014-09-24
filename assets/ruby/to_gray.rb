require 'RMagick'
include Magick
path = "Project1/images/notebook.jpg"
image_list = ImageList.new(path)
image = image_list[0]
gray_image = image.quantize(256, Magick::GRAYColorspace)
gray_image.write("Project1/images/notebook.tiff")

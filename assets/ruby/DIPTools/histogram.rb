module DIPTools
  class Histogram
    attr_reader :image, :total_pixels, :red, :green, :blue
    def initialize(image, no_of_bins, min, max)
      @image = image
      @no_of_bins = no_of_bins
      @total_pixels = image.rows * image.columns
      init_channels
    end

    def back_to_nimage
      new_image = @image
      new_image.red_channel.map! do |pixel|
        @red[pixel]
      end
      new_image.blue_channel.map! do |pixel|
        @blue[pixel]
      end
      new_image.green_channel.map! do |pixel|
        @green[pixel]
      end
      new_image
    end

    def rescale!(max)
      @channels.each do |channel|
        scale = max/channel.max
        channel.map! do |bin|
          bin * scale
        end
      end
    end

    private

    def init_channels
      @red   = to_histogram image.red_channel
      @green = to_histogram image.green_channel
      @blue  = to_histogram image.blue_channel
      @channels = [@red, @blue, @green]
    end

    def to_histogram(channel)
      bins = NMatrix.zeros([@no_of_bins])
      channel.each do |val|
        bins[val] += 1
      end
      bins
    end

    def normalize!
      @channels.each do |channel|
        channel.map! do |bin|
          bin/@total_pixels.to_f
        end
      end
    end

    def accumulate!
      @channels.each do |channel|
        sum = 0
        channel.map!{|bin| sum += bin}
      end
    end
  end

  class PDF < Histogram
    def initialize(image, no_of_bins, min, max)
      super(image, no_of_bins, min, max)
      normalize!
    end
  end

  class CDF < Histogram
    def initialize(image, no_of_bins, min, max)
      super(image, no_of_bins, min, max)
      normalize!
      accumulate!
    end

    def equalize!
      @channels.each do |channel|
        cdf_min = channel.find{|bin| bin > 0} # First non-zero bin
        channel.map! do |bin|
          result = bin * (@no_of_bins - 1)
          result.round
        end
      end
    end
  end
end

module DIPTools
  class NImage

    attr_reader :matrix, :image, :rows, :columns

    def initialize(path_or_matrix)
      parse_input(path_or_matrix)
    end

    def to_matrix
      pixel_array = @image.export_pixels(0, 0, @columns, @rows, "RGB")
      @matrix = pixel_array.to_nm [@columns, @rows, 3]
    end

    def to_image
      pixel_array = @matrix.to_flat_array
      new_image = @image
      new_image.import_pixels(0, 0, @columns, @rows, "RGB", pixel_array)
    end

    def histogram(no_of_bins, min = 0, max = (no_of_bins - 1) )
      Histogram.new(self, no_of_bins, min, max)
    end

    def pdf(no_of_bins, min = 0, max = (no_of_bins - 1) )
      PDF.new(self, no_of_bins, min, max)
    end

    def cdf(no_of_bins, min = 0, max = (no_of_bins - 1) )
      CDF.new(self, no_of_bins, min, max)
    end

    def red_channel
      @matrix[0..-1, 0..-1, 0]
    end

    def blue_channel
      @matrix[0..-1, 0..-1, 1]
    end

    def green_channel
      @matrix[0..-1, 0..-1, 2]
    end

    def threshold!(val, min = 0, max = (2**@image.depth - 1))
      @matrix.map! do |elem|
        if elem > val
          max
        else
          min
        end
      end
    end

    private

    def parse_input(path_or_matrix)
      case path_or_matrix
      when String
        image_list = ImageList.new(path_or_matrix)
        @image = image_list[0]
        @rows = @image.rows
        @columns = @image.columns
        to_matrix
      when NMatrix
        create_nimage_from_matrix(path_or_matrix)
      end
    end

    def create_nimage_from_matrix(nmatrix)
      nmatrix
      @rows = nmatrix.shape[0]
      @columns = nmatrix.shape[1]
      channels = nmatrix.shape[2]
      case channels
      when nil || 1
        @matrix = NMatrix.zeros([@rows, @columns, 3], dtype: :int16)
        [0,1,2].each do |index|
          @matrix[0..-1,0..-1,index] = nmatrix
        end
      when 3
        @matrix = nmatrix
      else
        # TODO RAISE REAL ERROR
        p "ERROR RAISED because you handed NImage a bad matrix, It should be rowxcolx1 or rowxcol or rowxcolx3"
      end
      @image = Image.new(@columns, @rows)
      pixel_array = @matrix.to_flat_array
      @image.import_pixels(0, 0, @columns, @rows, "RGB", pixel_array)
    end
  end
end

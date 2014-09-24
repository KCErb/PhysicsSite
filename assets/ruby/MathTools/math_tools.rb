module MathTools
  def self.gauss(x, mean, std, scale)
    norm_const = scale/Math.sqrt(2*Math::PI)
    1/std*norm_const*Math::E**(-1/2*((x-mean)/std)**2)
  end
end

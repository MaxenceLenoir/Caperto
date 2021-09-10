class CoordinateCalculator
  def initialize(attr = {})
    @latitute_start = attr[:latitude_start].latitude
    @longitude_start = attr[:longitude_start].longitude
    @latitute_end = attr[:latitude_end].latitude
    @longitude_end = attr[:longitude_end].longitude
  end

  def distance
    Math.acos(Math.sin(to_radian(@latitute_start)) * Math.sin(to_radian(@latitute_end)) + Math.cos(@latitude_start) * Math.cos(@latitude_end) * cos((@longitude_start - @longitude_end).abs))
  end

  def to_radian(degres)
    degres * (Math.PI / 180)
  end
end

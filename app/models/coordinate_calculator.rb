class CoordinateCalculator
  def initialize(attr = {})
    @latitude_start = attr[:latitude_start]
    @longitude_start = attr[:longitude_start]
    @latitude_end = attr[:latitude_end]
    @longitude_end = attr[:longitude_end]
  end

  def distance
    Math.acos(
      (Math.sin(to_radian(@latitude_start)) * Math.sin(to_radian(@latitude_end))) +
      (Math.cos(to_radian(@latitude_start)) * Math.cos(to_radian(@latitude_end)) * Math.cos((to_radian(@longitude_start) - to_radian(@longitude_end)).abs))
    ) * 6_371
  end

  def to_radian(degres)
    degres * (Math::PI / 180)
  end
end

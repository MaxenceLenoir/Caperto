class Capital < ApplicationRecord
  validates :name, :country, :latitude, :longitude, presence: true
  validates :longitude, presence: true, numericality: { less_than_or_equal_to: 90, greater_than_or_equal_to: -90 }
  validates :latitude, presence: true, numericality: { less_than_or_equal_to: 90, greater_than_or_equal_to: -90 }

  attr_accessor :distance_calculated

  def distance(coord)
    CoordinateCalculator.new(
      latitude_start: latitude,
      longitude_start: longitude,
      latitude_end: coord[:lat_end],
      longitude_end: coord[:long_end]
    ).distance.round(2)
  end
end

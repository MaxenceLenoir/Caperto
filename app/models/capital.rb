class Capital < ApplicationRecord
  validates :name, :country, :latitude, :longitude, presence: true
  validates :longitude, presence: true, numericality: { less_than_or_equal_to: 90, greater_than_or_equal_to: -90 }
  validates :latitude, presence: true, numericality: { less_than_or_equal_to: 90, greater_than_or_equal_to: -90 }

  attr_accessor :distance
end

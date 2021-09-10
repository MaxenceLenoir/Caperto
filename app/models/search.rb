class Search
  include ActiveModel::Model
  attr_accessor :latitude, :longitude, :radius

  validates :longitude, presence: true, numericality: { less_than_or_equal_to: 90, greater_than_or_equal_to: -90 }
  validates :latitude, presence: true, numericality: { less_than_or_equal_to: 90, greater_than_or_equal_to: -90 }
  validates :radius, presence: true, numericality: { greater_than: 0 }
end

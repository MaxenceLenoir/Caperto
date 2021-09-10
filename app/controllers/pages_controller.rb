class PagesController < ApplicationController
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

  def home
    @search = Search.new
  end

  def create
    @search = Search.new(params_search)
    if @search.valid?
      redirect_to result_path(latitude: @search.latitude, longitude: @search.longitude, radius: @search.radius,)
    else
      render 'home'
    end
  end

  def result
    capitals = Capital.all
    @capitals_under_radius = []
    capitals.each do |capital|
      distance = CoordinateCalculator.new(
        latitude_start: params[:latitude].to_f,
        longitude_start: params[:longitude].to_f,
        latitude_end: capital.latitude,
        longitude_end: capital.longitude
      ).distance
      @capitals_under_radius << { capital: capital, distance: distance.round(2) } if distance < params[:radius].to_f
    end
    @capitals_under_radius.sort_by! { |data| data[:distance] }
  end

  private

  def params_search
    params.require(:search).permit(:latitude, :longitude, :radius)
  end
end

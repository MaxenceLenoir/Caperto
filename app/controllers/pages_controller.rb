class PagesController < ApplicationController
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

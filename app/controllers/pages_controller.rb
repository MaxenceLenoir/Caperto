class PagesController < ApplicationController
  def home
    @search = Search.new
  end

  def search
    @search = Search.new(params_search)
    if @search.valid?
      redirect_to result_path(latitude: @search.latitude, longitude: @search.longitude, radius: @search.radius,)
    else
      render 'home'
    end
  end

  def result
    @capitals = Capital.all.to_a
    @capitals.each do |capital|
      capital.distance = CoordinateCalculator.new(
        latitude_start: params[:latitude].to_f,
        longitude_start: params[:longitude].to_f,
        latitude_end: capital.latitude,
        longitude_end: capital.longitude
      ).distance.round(2)
    end
    @capitals.filter! { |capital| capital.distance <= params[:radius].to_f.round(2) }
    @capitals.sort_by!(&:distance)

    @markers = @capitals.map do |capital|
      {
        lat: capital.latitude,
        lng: capital.longitude
      }
    end
  end

  private

  def params_search
    params.require(:search).permit(:latitude, :longitude, :radius)
  end
end

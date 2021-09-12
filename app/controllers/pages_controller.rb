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
    @capitals.filter! do |capital|
      capital.distance_calculated = capital.distance(lat_end: params[:latitude].to_f, long_end: params[:longitude].to_f)
      capital.distance_calculated <= params[:radius].to_f.round(2)
    end
    @capitals.sort_by!(&:distance_calculated)

    @markers = @capitals.map { |capital| { lat: capital.latitude, lng: capital.longitude } }
  end

  private

  def params_search
    params.require(:search).permit(:latitude, :longitude, :radius)
  end
end

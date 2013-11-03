class LocationSearchesController < ApplicationController
  before_action :set_location_search, only: [:show, :edit, :update, :destroy]

  def radius_search
    @location_search = LocationSearch.new()
    if params[:address_string] && params[:search_radius]
      @location_search.address.address_string = params[:address_string]
      @location_search.search_radius = params[:search_radius]
      @location_search.save
    end
  end

  def create
    @location_search = LocationSearch.new(params[:location_search])

    if @location_search.save
      respond_to do |format|
        format.js
        format.html { redirect_to jobs_path }
      end
    else
      raise StandardError, "You haven't done this yet"
    end
  end

  def index
    @location_searches = LocationSearch.all
  end

  private
  def set_location_search
    @location_search = LocationSearch.find(params[:id])
  end

  def job_search_criterion_params
    params.require(:location_search).permit(:active, :search_radius,
                                    :address_attributes => [:address_string])
  end
end
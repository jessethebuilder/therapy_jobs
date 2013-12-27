class LocationSearchesController < ApplicationController
  before_action :set_location_search, only: [:show, :edit, :update, :destroy]
  before_action :set_job_search_criterion, :only => [:create, :destroy]

  after_action :set_form_target, :only => [:new, :edit]

  #def radius_search
  #  @location_search = LocationSearch.new()
  #  if params[:address_string] && params[:search_radius]
  #    @location_search.address.address_string = params[:address_string]
  #    @location_search.search_radius = params[:search_radius]
  #    @location_search.save
  #  end
  #end

  def create
    @location_search = LocationSearch.new(location_search_params)

    if @location_search.save
      @job_search_criterion.location_searches << @location_search if @job_search_criterion
      respond_to do |format|
        format.js
      end
    else
      @validations_failed = true
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @location_search.destroy
    respond_to do |format|
      format.js{ render :action => 'create' }
    end
  end

  def index
    @location_searches = LocationSearch.all
  end

  private

  def set_form_target
    @form_target = [@job_search_criterion, @location_search]
  end

  def set_job_search_criterion
    if params[:job_search_criterion_id]
      @job_search_criterion = JobSearchCriterion.find(params[:job_search_criterion_id])
    end
  end

  def set_location_search
    @location_search = LocationSearch.find(params[:id])
  end

  def location_search_params
    params.require(:location_search).permit(:active, :search_radius,
                                    :address_attributes => [:address_string])
  end
end
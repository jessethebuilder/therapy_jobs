class JobSearchCriteriaController < ApplicationController
  include ApplicationHelper
  before_action :set_job_search_criterion, only: [:show, :edit, :update, :destroy]

  def search
    @job_search_criterion = current_jsc
    if @job_search_criterion.new_record?
      render :action => 'new'
    else
      render :action => 'edit'
    end
  end

  def new
    @job_search_criterion = JobSearchCriterion.new
  end

  def edit

  end

  def create
    @job_search_criterion = JobSearchCriterion.new(job_search_criterion_params)
    @j = job_search_criterion_params
    if @job_search_criterion.save
      session[:jsc_id] = @job_search_criterion.id
      @s = @job_search_criterion.states
      respond_to do |format|
        format.html{ redirect_to jobs_path }
        format.js
      end
    else
      raise StandardError, "You haven't done this yet"
    end
  end

  def update
    if @job_search_criterion.update(job_search_criterion_params)
      @j = job_search_criterion_params
      redirect_to jobs_path
    else
      raise StandardError, 'do it!!!'
    end
  end

  def destroy
    @job_search_criterion.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_job_search_criterion
    @job_search_criterion = JobSearchCriterion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_search_criterion_params
    params.require(:job_search_criterion).permit({:categories => []}, {:states => []}, {:settings => []}, {:duration_types => []},
                   :include_management, :location_searches_attributes => [:search_radius, :address_attributes])
    #params.require(:job_search_criterion).permit(:categories, :include_management, {:states => []}, :settings,
    #                                             :location_searches_attributes => [:search_radius, :address_attributes])
  end

end
class JobSearchCriteriaController < ApplicationController
  before_action :set_job_search_criterion, only: [:show, :edit, :update, :destroy]

  def new
    @job_search_criterion = JobSearchCriterion.new
    @location_search = @job_search_criterion.location_searches.new()
  end

  def create
    @job_search_criterion = JobSearchCriterion.new(params[:job_search_criterion])
    if @job_search_criterion.save
      redirect_to jobs_path
    else
      raise StandardError, "You haven't done this yet"
    end
  end

  def update
    @job_search_criterion.update(job_search_criterion_params)
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
    params.require(:job_search_criterion).permit(:categories, :include_management)
  end

end
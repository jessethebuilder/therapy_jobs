class JobSearchCriteriaController < ApplicationController
  before_action :set_job_search_criterion, only: [:show, :edit, :update, :destroy]

  def create
    @job_search_criterion = JobSearchCriterion.new(params[:job_search_criterion])
    @job_search_criterion.save
  end

  def update
    @job_search_criterion.update(job_search_criterion_params)
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
class QuickJobsController < ApplicationController
  before_action :set_quick_job, only: [:show, :edit, :update, :destroy]

  # GET /quick_jobs
  # GET /quick_jobs.json
  def index
    @quick_jobs = QuickJob.all
  end

  # GET /quick_jobs/1
  # GET /quick_jobs/1.json
  def show
  end

  # GET /quick_jobs/new
  def new
    @quick_job = QuickJob.new
  end

  # GET /quick_jobs/1/edit
  def edit
  end

  # POST /quick_jobs
  # POST /quick_jobs.json
  def create
    @quick_job = QuickJob.new(quick_job_params)

    respond_to do |format|
      if @quick_job.save
        format.html { redirect_to @quick_job, notice: 'Quick job was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quick_job }
      else
        format.html { render action: 'new' }
        format.json { render json: @quick_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quick_jobs/1
  # PATCH/PUT /quick_jobs/1.json
  def update
    respond_to do |format|
      if @quick_job.update(quick_job_params)
        format.html { redirect_to @quick_job, notice: 'Quick job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quick_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quick_jobs/1
  # DELETE /quick_jobs/1.json
  def destroy
    @quick_job.destroy
    respond_to do |format|
      format.html { redirect_to quick_jobs_url }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quick_job
      @quick_job = QuickJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quick_job_params
      params.require(:quick_job).permit(:title, :address1, :address2, :city, :state, :zip, :setting_type, :description)
    end
end

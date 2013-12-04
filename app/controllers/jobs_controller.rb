class JobsController < ApplicationController
  include ApplicationHelper
  before_action :set_job, only: [:show, :edit, :update, :destroy, :apply_to]

  def tj
    @jobs = Job.all
  end

  def index
    if known_user?
      @jobs = current_jsc.all_search
    else
      @jobs = Job.all
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @facility = @job.main_facility
    @contact = @job.contact
    @client = @job.client
    @address = @facility.address
  end

  def apply_to
    session[:applying_for] = @job.id
  end

  def flag

  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render action: 'show', status: :created, location: @job }
      else
        format.html { render action: 'new' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description, :benefits, :requirements, :desirements, :required_experience,
                                  :desired_experience, :start_date, :duration, :pay_rate)
    end
end

class JobFormSourcesController < ApplicationController
  before_action :set_job_form_source, only: [:show, :edit, :update, :destroy]

  # GET /job_form_sources
  # GET /job_form_sources.json
  def index
    @job_form_sources = JobFormSource.all
  end

  # GET /job_form_sources/1
  # GET /job_form_sources/1.json
  def show
  end

  # GET /job_form_sources/new
  def new
    @job_form_source = JobFormSource.new
  end

  # GET /job_form_sources/1/edit
  def edit
  end

  # POST /job_form_sources
  # POST /job_form_sources.json
  def create
    @job_form_source = JobFormSource.new(job_form_source_params)

    respond_to do |format|
      if @job_form_source.save
        format.html { redirect_to @job_form_source, notice: 'Job form source was successfully created.' }
        format.json { render action: 'show', status: :created, location: @job_form_source }
      else
        format.html { render action: 'new' }
        format.json { render json: @job_form_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_form_sources/1
  # PATCH/PUT /job_form_sources/1.json
  def update
    respond_to do |format|
      if @job_form_source.update(job_form_source_params)
        format.html { redirect_to @job_form_source, notice: 'Job form source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job_form_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_form_sources/1
  # DELETE /job_form_sources/1.json
  def destroy
    @job_form_source.destroy
    respond_to do |format|
      format.html { redirect_to job_form_sources_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_form_source
      @job_form_source = JobFormSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_form_source_params
      params.require(:job_form_source).permit(:name, :content, :category_id, :company_id)
    end
end

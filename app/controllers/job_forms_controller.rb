class JobFormsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_job_form, only: [:show, :edit, :update, :destroy, :process_form]


  # GET /job_forms
  # GET /job_forms.json
  def index
    @job_forms = JobForm.all
  end

  # GET /job_forms/1
  # GET /job_forms/1.json
  def show

  end

  # GET /job_forms/new
  def new
    @job_form = JobForm.new
    cat = Category.where(:code => params[:category_code]) if params[:category_code]
    cat = nil if cat.blank?
    @job_form_source = JobFormSource.where(:name => params[:name], :category => cat)
    @job_form.job_form_source = @job_form_source
  end

  # GET /job_forms/1/edit
  def edit

  end

  def fill_out
    @rb_count = 0
    @job_form = JobForm.for_user(current_user, params[:name], params[:code])

    respond_to do |format|
      format.html{ render :action => 'form'}
    end
  end

  def process_form
    @job_form.save_answers(params).save
    #todo
    redirect_to root_path
  end

  def create
    @job_form = JobForm.new(job_form_params)

    respond_to do |format|
      if @job_form.save
        format.html { redirect_to @job_form, notice: 'Job form was successfully created.' }
        format.json { render action: 'show', status: :created, location: @job_form }
      else
        format.html { render action: 'new' }
        format.json { render json: @job_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_forms/1
  # PATCH/PUT /job_forms/1.json
  def update
    respond_to do |format|
      if @job_form.update(job_form_params)
        format.html { redirect_to @job_form, notice: 'Job form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_forms/1
  # DELETE /job_forms/1.json
  def destroy
    @job_form.destroy
    respond_to do |format|
      format.html { redirect_to job_forms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_form
      @job_form = JobForm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_form_params
      params.require(:job_form).permit(:q_a_hash, :job_form_source_id)
    end
end

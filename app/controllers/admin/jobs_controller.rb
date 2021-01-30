class Admin::JobsController < ApplicationController
  before_action :require_is_admin
  before_action :find_job, only: [:show, :edit, :update, :destroy, :publish, :hide]
  layout "admin"
  def index
    @jobs = Job.all
  end

  def show
    
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to admin_jobs_path, notice: "Create Success"
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @job.update(job_params)

      redirect_to admin_jobs_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    flash[:alert] = "Job deleted"
    redirect_to admin_jobs_path
  end

  def publish
    @job.publish!
    redirect_to admin_jobs_path,notice: 'Publish Success'  
  end

  def hide
    @job.hide!
    redirect_to admin_jobs_path,notice: 'Hide Success'  
  end

  private
  
  def find_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title,:description,:wage_lower_bound, :wage_upper_bound, :contact_email,:is_hidden)
  end
end

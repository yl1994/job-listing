class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_job, only: [:show, :edit, :update, :destroy]
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
      redirect_to jobs_path, notice: "Create Success"
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @job.update(job_params)

      redirect_to jobs_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    flash[:alert] = "Group deleted"
    redirect_to jobs_path
  end

  private
  
  def find_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title,:description)
  end
end

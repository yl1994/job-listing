class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_job, only: [:show, :edit, :update, :destroy]
  def index
    @jobs = case params[:order]
                when 'by_lower_bound'
                  Job.published.order('wage_lower_bound DESC')
                when 'by_upper_bound'
                  Job.published.order('wage_upper_bound DESC')
                else
                  Job.published.recent
                end
  end

  def show
    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to root_path
    end
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
    flash[:alert] = "Job deleted"
    redirect_to jobs_path
  end

  private
  
  def find_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title,:description,:wage_lower_bound, :wage_upper_bound, :contact_email,:is_hidden)
  end
end

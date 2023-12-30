class TasksController < ApplicationController

  before_action :admin?, only: [:complete, :delay, :expire, :uncomplete]

  #Notifiche
  after_action only: [:complete] do Task.task_notice(@task,'Completed') end
  after_action only: [:expire] do Task.task_notice(@task,'Expired') end
  after_action only: [:delay] do Task.task_notice(@task,'Delayed') end


  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])

    @taskGroup = Task.taskGroup(@task)
  end

  def edit
    @task = Task.find(params[:id])

    if not Project.manager?(@task.project, current_user)
      not_authorized
    end

  end

  def update

    @task = Task.find(params[:id])

    if not Project.manager?(@task.project, current_user)
      not_authorized
    else
      if @task.update(task_params)
        Task.task_notice(@task,'Edit')
        redirect_to @task
      else
        render :edit, status: :unprocessable_entity
      end
    end

  end

  def destroy

    @task = Task.find(params[:id])

    if Project.manager?(@task.project, current_user)
      @task.destroy
      Task.task_notice(@task,'Deleted')
      redirect_to action: "index"

    else
      not_authorized
    end

  end

  def new
    @task = Task.new

    @project = Project.find(project_params)

    if not Project.manager?(@project, current_user)
      not_authorized
    end

  end

  def create

    @task = Task.new(task_params)

    if not Project.manager?(@task.project, current_user)
      not_authorized
    else
      if @task.save
        Task.task_notice(@task,'Created')
        redirect_to @task
      else
        params[:project_id] = @task.project_id
        render :new, status: :unprocessable_entity
      end
    end

  end

  def complete
    @task = Task.find(params[:id])

    Task.set_complete(@task)

    redirect_to @task

  end

  def uncomplete
    @task = Task.find(params[:id])

    Task.set_uncomplete(@task)

    redirect_to @task
  end

  def expire
    @task = Task.find(params[:id])

    Task.set_expire(@task)

    redirect_to @task
  end

  def delay
    @task = Task.find(params[:id])

    Task.set_delay(@task)

    redirect_to @task
  end

  private
    def task_params
      params.require(:task).permit(:title, :description, :start_date, :expiration_date, :project_id)
    end
  private
    def project_params
      params.require(:project_id)
    end

end

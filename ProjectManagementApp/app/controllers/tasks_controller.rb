class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])

    if not Project.manager?(@task.project, current_user)
      not_authorized
    end

  end

  def update

    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to @task
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy

    @task = Task.find(params[:id])

    if Project.manager?(@task.project, current_user)

      @task.destroy
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
        redirect_to @task
      else
        params[:project_id] = @task.project_id
        render :new, status: :unprocessable_entity
      end
    end

  end

  private
    def task_params
      params.require(:task).permit(:title, :description, :start_date, :expiration_date, :project_id)
    end

    def project_params
      params.require(:project_id)
    end

end

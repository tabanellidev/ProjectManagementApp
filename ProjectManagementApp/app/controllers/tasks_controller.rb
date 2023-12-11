class TasksController < ApplicationController

  def manager?

    (@task.project.users.distinct.pluck("id").include? current_user.id) or (@current_user.role == 'admin')

  end

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])

    if not manager?
      puts("do not manage")
      redirect_to :controller => "main", :action => 'notauthorized'
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

    if manager?

      @task.destroy

      redirect_to action: "index"

    else

      redirect_to :controller => "main", :action => 'notauthorized'

    end

  end

  def new
    @task = Task.new

    @project = Project.find(project_params)

    if not ((@project.users.distinct.pluck("id").include? current_user.id) or (@current_user.role == 'admin'))
      redirect_to :controller => "main", :action => 'notauthorized'
    end

  end

  def create

    @task = Task.new(task_params)
    #Da considerare soluzione alternativa
    if not manager?
      puts("do not manage")
      redirect_to :controller => "main", :action => 'notauthorized'
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

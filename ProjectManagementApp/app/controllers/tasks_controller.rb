class TasksController < ApplicationController

  before_action :admin?, only: [:destroy]

  def manager?

    if (! @task.project.users.distinct.pluck("id").include? current_user.id) or (! @current_user.role == 'admin')

      puts("do not manage")
      redirect_to :controller => "main", :action => 'notauthorized'

    end

  end

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])

    #manager?
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
    @task.destroy

    redirect_to action: "index"

  end

  def new
    @task = Task.new
  end

  def create

    @task = Task.new(task_params)

    #manager?

    if @task.save
      redirect_to @task
    else
      render :new, status: :unprocessable_entity
    end

  end

  private
    def task_params
      params.require(:task).permit(:title, :description, :project_id)
    end

end

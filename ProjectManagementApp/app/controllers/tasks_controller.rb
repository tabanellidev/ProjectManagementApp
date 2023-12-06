class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
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
    puts task_params
    @task = Task.new(task_params)

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

class AssignmentsController < ApplicationController
  def index
    @assignments = Assignment.all
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def update

    @assignment = Assignment.find(params[:id])

    if @assignment.update(assignment_params)
      redirect_to @assignment
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy

    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    redirect_to action: "index"

  end

  def complete
    @assignment = Assignment.find(params[:id])

    @assignment.completed = 1
    @assignment.save

    task_completed = true

    @assignment.task.assignments.each do |assignment|
      if not assignment.completed?
        task_completed = false
      end
    end

    if task_completed
      @task = Task.find(@assignment.task.id)
      task.completed = 1
      @task.save
    end

    redirect_to @assignment
  end

  def uncomplete
    @assignment = Assignment.find(params[:id])

    @assignment.completed = 0
    @assignment.save

    redirect_to @assignment
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      redirect_to @assignment
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def assignment_params
    params.require(:assignment).permit(:title, :description, :user_id, :task_id)
  end

end

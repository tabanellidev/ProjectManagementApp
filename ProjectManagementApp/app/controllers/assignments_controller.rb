class AssignmentsController < ApplicationController

  def manager?

    (@assignment.task.project.users.distinct.pluck("id").include? current_user.id) or (@current_user.role == 'admin')

  end

  def index
    @assignments = Assignment.all
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def edit
    @assignment = Assignment.find(params[:id])

    if not manager?
      puts("do not manage")
      redirect_to :controller => "main", :action => 'notauthorized'
    end

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

    if manager?

      @assignment.destroy

      redirect_to action: "index"

    else

      redirect_to :controller => "main", :action => 'notauthorized'

    end

  end

  def complete
    @assignment = Assignment.find(params[:id])

    if @assignment.user.id == current_user.id || current_user.role == 'admin'

      @assignment.completion_date = Date.today

      if @assignment.completion_date <= @assignment.expiration_date
        @assignment.status = 'Completed'
      else
        @assignment.status = 'Delayed'
      end

      @assignment.save

      Task.complete(@assignment.task)

      redirect_to @assignment

    else

      redirect_to :controller => "main", :action => 'notauthorized'

    end


  end

  def uncomplete
    @assignment = Assignment.find(params[:id])

    @assignment.status = 0
    @assignment.save

    redirect_to @assignment
  end

  def expire
    @assignment = Assignment.find(params[:id])

    @assignment.status = 2
    @assignment.save

    redirect_to @assignment
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(assignment_params)

    if not manager?
      puts("do not manage")
      redirect_to :controller => "main", :action => 'notauthorized'
    else

      if @assignment.save
        redirect_to @assignment
      else
        params[:task_id] = @assignment.task_id
        render :new, status: :unprocessable_entity
      end

    end
  end

  private
  def assignment_params
    params.require(:assignment).permit(:title, :description, :start_date, :expiration_date, :user_id, :task_id)
  end

end

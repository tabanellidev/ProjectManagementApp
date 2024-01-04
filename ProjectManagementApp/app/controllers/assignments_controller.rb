class AssignmentsController < ApplicationController

  before_action :admin?, only: [:expire, :delay]

  after_action only: [:expire] do Assignment.assignment_notice(@assignment,'Expired') end
  after_action only: [:delay] do Assignment.assignment_notice(@assignment,'Delayed') end

  def index
    @assignments = Assignment.all
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def edit
    @assignment = Assignment.find(params[:id])

    if not Project.manager?(@assignment.task.project, current_user)
      not_authorized
    end

    #Per scegliere un nuovo utente per l'assegnazione nella view
    @user_array = User.all.map { |user| [user.id.to_s + " - " + user.name + " " + user.surname, user.id] }


  end

  def update

    @assignment = Assignment.find(params[:id])
    @old_id = @assignment.user_id

    if not Project.manager?(@assignment.task.project, current_user)
      not_authorized

    else
      if @assignment.update(assignment_params)
        Assignment.deallocate_and_assign_notification(@assignment, @old_id)
        redirect_to @assignment
      else
        render :edit, status: :unprocessable_entity
      end

    end

  end

  def destroy

    @assignment = Assignment.find(params[:id])

    if Project.manager?(@assignment.task.project, current_user)

      @assignment.destroy

      Assignment.assignment_notice(@assignment,'Deleted')

      redirect_to action: "index"

    else
      not_authorized
    end

  end

  def new
    @assignment = Assignment.new

    @task = Task.find(task_params)

    if not Project.manager?(@task.project, current_user)
      not_authorized
    end

    #Per scegliere un nuovo utente per l'assegnazione nella view
    @user_array = User.all.map { |user| [user.id.to_s + " - " + user.name + " " + user.surname, user.id] }

  end

  def create
    @assignment = Assignment.new(assignment_params)

    if not Project.manager?(@assignment.task.project, current_user)
      not_authorized
    else

      if @assignment.save
        Assignment.create_and_assign_notification(@assignment)
        redirect_to @assignment
      else
        params[:task_id] = @assignment.task_id
        render :new, status: :unprocessable_entity
      end

    end
  end

  def complete
    @assignment = Assignment.find(params[:id])


    if Assignment.owner(@assignment, current_user)

      Assignment.complete(@assignment)

      redirect_to @assignment

    else
      not_authorized
    end

  end

  def uncomplete
    @assignment = Assignment.find(params[:id])

    Assignment.set_uncomplete(@assignment)

    redirect_to @assignment
  end

  def expire
    @assignment = Assignment.find(params[:id])

    Assignment.set_expire(@assignment)

    redirect_to @assignment
  end

  def delay
    @assignment = Assignment.find(params[:id])

    Assignment.set_delay(@assignment)

    redirect_to @assignment
  end

  private
    def assignment_params
      params.require(:assignment).permit(:title, :description, :start_date, :expiration_date, :user_id, :task_id)
    end

  private
    def task_params
      params.require(:task_id)
    end

end

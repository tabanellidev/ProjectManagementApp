class ProjectsController < ApplicationController

  before_action :admin?, only: [:destroy, :complete, :delay, :expire, :uncomplete]
  before_action :senior?, only: [:new, :create]

  #Notifiche
  after_action only: [:complete] do Project.project_notice(@project, "Completed") end
  after_action only: [:expire] do  Project.project_notice(@project,'Expired') end
  after_action only: [:delay] do  Project.project_notice(@project,'Delayed') end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])

    @projectGroup = Project.projectGorup(@project)

  end

  def edit

    @project = Project.find(params[:id])

    if not Project.manager?(@project, current_user)
      not_authorized
    end

  end

  def update

    @project = Project.find(params[:id])

    if not Project.manager?(@project, current_user)
      not_authorized
    else

      if @project.update(project_params)

        Project.project_notice(@project,'Edit')

        redirect_to @project
      else
        render :edit, status: :unprocessable_entity
      end

    end

  end

  def destroy

    @project = Project.find(params[:id])
    @project.destroy

    redirect_to action: "index"

  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save

      @manage = Manage.new(user_id: current_user.id, project_id: @project.id)
      @manage.save

      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end

  end

  def complete
    @project = Project.find(params[:id])

    Project.set_complete(@project)

    redirect_to @project

  end

  def uncomplete
    @project = Project.find(params[:id])

    Project.set_uncomplete(@project)

    redirect_to @project
  end

  def expire
    @project = Project.find(params[:id])

    Project.set_expire(@project)

    redirect_to @project
  end

  def delay
    @project = Project.find(params[:id])

    Project.set_delay(@project)

    redirect_to @project
  end

  private
    def project_params
      params.require(:project).permit(:title, :description, :client, :start_date, :expiration_date)
  end

end

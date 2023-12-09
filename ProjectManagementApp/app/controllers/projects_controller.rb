class ProjectsController < ApplicationController

  before_action :admin?, only: [:destroy]
  before_action :senior?, only: [:new, :create]

  def manager?

    (@project.users.distinct.pluck("id").include? current_user.id) or (@current_user.role == 'admin')

  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit

    @project = Project.find(params[:id])

    if not manager?
      puts("do not manage")
      redirect_to :controller => "main", :action => 'notauthorized'
    end

  end

  def update

    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity
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

  private
    def project_params
      params.require(:project).permit(:title, :description)
  end

end

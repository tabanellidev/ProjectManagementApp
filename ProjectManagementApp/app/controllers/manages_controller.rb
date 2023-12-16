class ManagesController < ApplicationController

  before_action :senior?, only: [:edit, :update, :destroy, :new, :create]

  def index

    @manages = Manage.all

  end

  def show
    @manage = Manage.find(params[:id])
  end

  def edit
    @manage = Manage.find(params[:id])

    if not Project.manager?(@manage.project, current_user)
      not_authorized
    end

  end

  def update

    @manage = Manage.find(params[:id])

    if not Project.manager?(@manage.project, current_user)
      not_authorized
    else

      if @manage.update(manage_params)
        redirect_to @manage
      else
        render :edit, status: :unprocessable_entity
      end

    end

  end

  def destroy

    @manage = Manage.find(params[:id])

    if not Project.manager?(@manage.project, current_user)
      not_authorized
    else
      @manage.destroy
      redirect_to action: "index"
    end

  end


  def new
    @manage = Manage.new

    @project = Project.find(project_params)

    if not Project.manager?(@project, current_user)
      not_authorized
    end

  end

  def create
    @manage = Manage.new(manage_params)

    @project = Project.find(@manage.project_id)

    if Project.manager?(@project, current_user)
      if @manage.save
        redirect_to @manage
      else
        params[:project_id] = @manage.project_id
        render :new, status: :unprocessable_entity
      end
    else
      not_authorized
    end


  end

  private
  def manage_params
    params.require(:manage).permit(:user_id, :project_id)
  end

  private
    def project_params
      params.require(:project_id)
    end

end

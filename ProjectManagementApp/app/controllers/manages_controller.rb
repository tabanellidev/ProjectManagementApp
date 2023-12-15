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

    if @manage.update(manage_params)
      redirect_to @manage
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy

    @manage = Manage.find(params[:id])

    if manager?
      @manage.destroy
      redirect_to action: "index"
    else
      redirect_to :controller => "main", :action => 'notauthorized'
    end

  end


  def new
    @manage = Manage.new
  end

  def create
    @manage = Manage.new(manage_params)

    if Project.manager?(@manage.project, current_user)
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

end

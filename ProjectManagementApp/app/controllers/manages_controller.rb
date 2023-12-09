class ManagesController < ApplicationController

  before_action :senior?, only: [:edit, :update, :destroy, :new, :create]

  def manager?

    (@manage.project.users.distinct.pluck("id").include? current_user.id) or (@current_user.role == 'admin')

  end

  def index

    @manages = Manage.all
    @id_list = Manage.all.distinct.pluck("project_id")

    @project_list = Project.find(@id_list)

    puts(@project_list)

  end

  def show
    @manage = Manage.find(params[:id])
  end

  def edit
    @manage = Manage.find(params[:id])

    if not manager?
      puts("do not manage")
      redirect_to :controller => "main", :action => 'notauthorized'
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

    puts(@manage.project_id)

    if manager?
      if @manage.save
        redirect_to @manage
      else
        params[:project_id] = @manage.project_id
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to :controller => "main", :action => 'notauthorized'
    end


  end

  private
  def manage_params
    params.require(:manage).permit(:user_id, :project_id)
  end

end

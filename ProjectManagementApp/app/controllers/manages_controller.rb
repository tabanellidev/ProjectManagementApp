class ManagesController < ApplicationController
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
    @manage.destroy

    redirect_to action: "index"

  end


  def new
    @manage = Manage.new
  end

  def create
    @manage = Manage.new(manage_params)

    if @manage.save
      redirect_to @manage
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def manage_params
    params.require(:manage).permit(:user_id, :project_id)
  end

end

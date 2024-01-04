class UsersController < ApplicationController

  before_action :admin?, except: [:index, :show]


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    @workedTask = User.workedTask(@user)

    @projectManaged = User.projectManaged(@user)

  end

  def show_notifications

    @user = User.find(params[:id])

    @notifications = @user.notifications.reverse

  end

  def edit
    @user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])

    if @user.update(user_params)
     redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end


  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end

  end

  def destroy

    @user = User.find(params[:id])

    @user.destroy
    redirect_to action: "index"

  end

  private
    def user_params
      params.require(:user).permit(:email, :role, :name, :surname, :password, :password_confirmation)
    end

end

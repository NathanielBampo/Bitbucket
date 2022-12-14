class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end

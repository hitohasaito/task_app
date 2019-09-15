class UsersController < ApplicationController
  #before_action :access_permit,only:[:show]
  before_action :check_login, only:[:new]
  before_action :set_id, only:[:show]
  before_action :authenticate_user, only:[:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user.id)
    else
      render "new"
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_id
    @user = User.find(params[:id])
  end

  def check_login
    if current_user.present?
      redirect_to new_task_path, notice: "ユーザー登録済みです"
    end
  end

  def authenticate_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to tasks_path flash[:notice]= "権限がありません"
    end
  end
end

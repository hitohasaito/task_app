class UsersController < ApplicationController
  before_action :set_id, only:[:show]
  before_action :check_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
      @current_user.present?
      redirect_to new_task_path
      flash[:notice]= "ユーザー登録済みです"
  end
end

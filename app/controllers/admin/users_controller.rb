class Admin::UsersController < ApplicationController
  before_action :set_id, only:[:show, :edit, :update, :destroy]
  before_action :require_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user.id), notice: "管理者画面でユーザーを登録しました"
    else
      render "new"
    end
  end

  def show
  end

  def index
    @users = User.all.includes(:tasks)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_id
    @user = User.find(params[:id])
  end

  def require_admin
    raise MyError unless current_user.present? && current_user.admin?
  end
end

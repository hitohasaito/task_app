class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to new_task_path
      flash[:notice] = "ログインしました"
    else
      render "new"
      flash[:notice] = "ログインしてください"
    end
  end
end

class TasksController < ApplicationController
  PER = 7
  before_action :authenticate_user,only:[:show, :edit, :update, :destroy]
  before_action :find_params, only:[:show, :edit, :update, :destroy]
  before_action :access_permit

  def new
      @task = Task.new
  end

  def create
    #binding.pry
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:notice] = "新規登録しました"
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def index
    @task_new = Task.new
    if params[:sort_expired]
      @tasks = Task.page(params[:page]).per(PER).order(:task_limit)
    else
      @tasks = Task.page(params[:page]).per(PER).order(created_at: :desc)
    end

    if params[:sort_createday]
      @tasks = Task.page(params[:page]).per(PER).order(created_at: :desc)
    end

    if params[:sort_priority]
      @tasks = Task.page(params[:page]).per(PER).order(:task_priority)
    end

    if params[:task]
      @tasks = Task.page(params[:page]).per(PER).get_task(params[:task][:task_name]).get_status(params[:task][:task_status])
    else
      Task.page(params[:page]).per(PER).order(created_at: :desc)
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "編集しました"
      redirect_to tasks_path
    else
      render "edit"
    end
  end

  def destroy
     @task.destroy
     flash[:notice] = "削除しました"
     redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :task_body, :task_limit, :task_status, :task_priority, labelling_labels_ids: [])
  end

  def find_params
    @task = Task.find(params[:id])
  end

  def authenticate_user
    @task = Task.find(params[:id])
    unless current_user.present? && @task.user_id == current_user.id
    redirect_to tasks_path, notice:"権限がありません"
    end
  end
end

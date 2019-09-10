class TasksController < ApplicationController
  PER = 7
  before_action :access_permit,only:[:index, :show, :edit]
  before_action :find_params,only:[:show, :edit, :update, :destroy]
  def new
      @task = Task.new
  end

  def create
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
    params.require(:task).permit(:task_name, :task_body, :task_limit, :task_status, :task_priority)
  end

  def find_params
    @task = Task.find(params[:id])
  end

  def access_permit
    if current_user.nil?
      flash[:notice]= "ログインしてください"
      redirect_to new_session_path
    end
  end
end

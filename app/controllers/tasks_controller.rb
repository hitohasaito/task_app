class TasksController < ApplicationController
  before_action :find_params,only:[:show, :edit, :update, :destroy]
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "新規登録しました"
      redirect_to tasks_path
    else
      render "new"
    end
  end
  def index
    @tasks = Task.all.order(created_at: :desc)
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
    params.require(:task).permit(:task_name, :task_body, :task_limit)
  end
  def find_params
    @task = Task.find(params[:id])
  end
end

class TasksController < ApplicationController
  before_action :find_params,only:[:show,:edit,:update]
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render "new"
    end
  end
  def index
    @tasks = Task.all
  end
  def show
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render "edit"
    end
  end

private

  def task_params
    params.require(:task).permit(:task_name,:task_body)
  end
  def find_params
    @task = Task.find(params[:id])
  end
end

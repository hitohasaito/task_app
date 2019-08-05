class TasksController < ApplicationController
  before_action :find_params,only:[:show]
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

private

  def task_params
    params.require.(:task).permit(:task_name, :task_body)
  end
  def find_params
    @task = Task.find(params[:id])
  end
end

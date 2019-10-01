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
    #binding.pry
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
      #binding.pry
      if  params[:task][:label_id].empty?
        @tasks = Task.page(params[:page]).per(PER).get_task(params[:task][:task_name]).get_status(params[:task][:task_status])

      elsif params[:task][:task_name] && params[:task][:label_id].present?#タスク名とラベルが検索条件にあったら、ラベル名とタスク名(部分一致可)に合った結果を返す
          tasks = Task.get_task_and_label(
            task_name: params[:task][:task_name],
            label_id: params[:task][:label_id]
          )
        @tasks = Kaminari.paginate_array(tasks).page(params[:page]).per(PER)

      elsif params[:task][:task_name] && params[:task][:task_status]&& params[:task][:label_id].present?#全ての項目が検索条件にあったら
        tasks = Task.get_task_and_status_and_label(
          task_name: params[:task][:task_name],
          label_id: params[:task][:label_id],
          task_status: params[:task][:task_status]
        )
        @tasks = Kaminari.paginate_array(tasks).page(params[:page]).per(PER)

      elsif params[:task][:task_status] && params[:task][:label_id].present?#ステータスとラベルが検索条件にあったら
        task = Labelling
        .where(label_id:params[:task][:label_id])
        .pluck(:task_id)
        .map { |task_id| Task.find(task_id) }
        .select { |t| t.task_status == params[:task][:task_status]}
        @tasks = Kaminari.paginate_array(task).page(params[:page]).per(PER)

      else
          @tasks = Task.page(params[:page]).per(PER).order(created_at: :desc)
      end
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
    params.require(:task).permit(:task_name, :task_body, :task_limit, :task_status, :task_priority, label_ids: [])
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

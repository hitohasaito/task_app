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
      @tasks = Task.page(params[:page]).per(PER).get_task(params[:task][:task_name]).get_status(params[:task][:task_status])
    else
      @tasks = Task.page(params[:page]).per(PER).order(created_at: :desc)
    end

    if params[:task]
      if params[:task][:task_name] && params[:task][:task_body]&& params[:task][:label_id].present?
        @tasks = Task.page(params[:page]).per(PER).get_task(params[:task][:task_name]).get_status(params[:task][:task_status])

      elsif params[:task][:task_name] && params[:task][:label_id].present?
        #送られてきたラベルのIDに合致するtask_idを取得
        task = Labelling
          .where(label_id:params[:task][:label_id]) # [Labeling(label_id: 1, task_id: 1), Labeling(label_id: 1, task_id: 2), Labeling(label_id: 1, task_id: 3) ]
          .pluck(:task_id) # [1, 2, 3] task_id
          .map { |task_id| Task.find(task_id) } #[Task(1), Task(2), Task(3)]
          .select { |t| t.task_name == params[:task][:task_name] }
       @tasks = Kaminari.paginate_array(task).page(params[:page]).per(PER)


      elsif params[:task][:label_id].present?
           task_array = Labelling.where(label_id:params[:task][:label_id]).pluck(:task_id)
           task = Task.find(task_array)
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

# # map例
# results = []
# arrays = [1, 2, 3]
#
# arrays.each do |a|
#   results.push(a * 2)
# end
#
# # map解
# arrays = [1, 2, 3]
#
# results = arrays.map do |a|
#   a * 2
# end
#
# # map解2
# arrays = [1, 2, 3]
#
# results = arrays.map { |a| a * 2 }
#
# # fliter + map例 3の倍数は通さない
# results = []
# arrays = [1, 2, 3]
#
# arrays.each do |a|
#   results.push(a * 2) unless a % 3 == 0
# end
#
# results -> [2, 4]
#
#
# # fliter + map  3の倍数は通さない
# arrays = [1, 2, 3]
#
# results = arrays
#             .select { |a| a % 3 != 0 } # [1, 2]
#             .map { |a| a * 2 }
#
# results -> [2, 4]

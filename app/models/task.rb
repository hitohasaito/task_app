class Task < ApplicationRecord
  validates :task_name, presence:true

  def self.search(task)
    #Taskはcalssなので、classメソッドだからselfをつける
    #binding.pry
    if task
      Task.where( "task_name LIKE ? AND task_status LIKE ?", "%#{task[:task_name]}%", "%#{task[:task_status]}%")
    elsif
      Task.where( "task_name LIKE ? OR task_status LIKE ?", "%#{task[:task_name]}%", "%#{task[:task_status]}%")
    else
      Task.all.order(created_at: :desc)
    end
  end
end
#もし、検索条件が2つ存在していたら、どちらにも一致する結果を変えず
#もし、タスク名が存在していたら、タスク名に部分的にも一致したタスクの情報を返す
#もし、ステータスが存在していたら、ステータスに該当するタスクの情報を返す
#コンソールでハッシュ[:キー]と打つと、

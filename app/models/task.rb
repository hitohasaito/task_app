class Task < ApplicationRecord

  validates :task_name, presence:true

  scope :get_task, ->task_name{where("task_name LIKE ?", "%#{task_name}%")}
  scope :get_status, ->task_status{where("task_status LIKE ?", "%#{task_status}%")}

  enum task_priority:{"高": 0, "中": 1, "低": 2}

  belongs_to :user
end

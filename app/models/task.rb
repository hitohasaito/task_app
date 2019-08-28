class Task < ApplicationRecord

  validates :task_name, presence:true

  scope :get_task, ->task_name{where("task_name LIKE ?", "%#{task_name}%")}
  scope :get_status, ->task_status{where("task_status LIKE ?", "%#{task_status}%")}
end

class Task < ApplicationRecord

  validates :task_name, presence:true

  scope :get_task, ->task_name{where("task_name LIKE ?", "%#{task_name}%")}
  scope :get_task_and_label, -> (task_name: task_name, label_id: label_id) do
    joins(:labels).where(labels: { id: label_id }).where("task_name LIKE ?", "%#{task_name}%")
  end

  # scope :get_task_and_label, -> (task_name: task_name, label_id: label_id) do
  #   joins(:labels).where(labels: { id: label_id }).where(task_name: task_name)
  # end
  #
  scope :get_status, ->task_status{where("task_status LIKE ?", "%#{task_status}%")}
  enum task_priority:{"高": 0, "中": 1, "低": 2}

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings, source: :label

  # def self.get_task_and_label(task_name: task_name, label_id: label_id)
  #   Task.joins(:labels).where(labels: { id: label_id }).where("task_name LIKE ?", "%#{task_name}%")
  # end
end


# where(task_nameのあいまい検索 と label_id の条件)


# PURPOSE: label_idとtask_nameでtaskを等しいものだけゲット
# label_idがある
# labellingを見つけてtask_ids
# task_idsをmapでfind
# mapでtask_nameをとってparamsで受け取ったtasknameとひとしいか確認して

# label_idでwhereでフィルタリング　して残りをtasknameでwhere


# PURPOSE: paramsで受けとったlabel_idに紐づいてるtask　でtask_nameであいまい検索したい
# label_idでwhereでフィルタリング
# 残りのあたいで曖昧検索

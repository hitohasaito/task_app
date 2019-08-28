FactoryBot.define do

  factory :task do
    task_name { 'taskname1' }
    task_body { 'tasktask1' }
    task_status { '未着手' }
    created_at { DateTime.now+1.days }
    task_limit {DateTime.now+2.day }
  end

  factory :second_task, class: Task do
    task_name { 'taskname2' }
    task_body { 'tasktask2' }
    task_status { '完了' }
    created_at { DateTime.now+3.days }
    task_limit { DateTime.now+1.days }
  end

  factory :third_task, class: Task do
    task_name { 'taskname3' }
    task_body { 'tasktask3' }
    task_status { '着手中' }
    created_at { DateTime.now+2.days }
    task_limit {DateTime.now+3.days }
  end
end

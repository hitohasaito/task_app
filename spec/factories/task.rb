FactoryBot.define do

  factory :task do
    task_name { 'taskname1' }
    task_body { 'tasktask1' }
  end

  factory :second_task, class: Task do
    task_name { 'taskname2' }
    task_body { 'tasktask2' }
  end

  factory :third_task, class: Task do
    task_name { 'taskname3' }
    task_body { 'tasktask3' }
  end
end

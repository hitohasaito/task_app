FactoryBot.define do
  factory :labelling do
    task_id { 1 }
    label_id { 1 }
  end

  factory :second_labelling, class: Labelling do
    task_id { 2 }
    label_id { 2 }
  end
end

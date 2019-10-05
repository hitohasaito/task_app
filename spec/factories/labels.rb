FactoryBot.define do
  factory :label do
    id {1}
    label_name { "label1" }
  end

  factory :second_label, class: Label do
    id {2}
    label_name { "label2" }
  end
end

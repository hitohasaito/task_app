require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
 scenario "タスク一覧のテスト" do
  Task.create!(task_name:"task1",task_body:"tasktask1")
  Task.create!(task_name:"task2",task_body:"tasktask2")

   visit tasks_path
 
  expect(page).to have_content "tasktask1"
  expect(page).to have_content "tasktask2"
 end

 scenario "タスク作成のテスト" do
   visit new_task_path

   fill_in "task[task_name]", with: "庭掃除"
   fill_in "task[task_body]", with: "草刈りをする"

   click_button "Create Task"

   visit task_path(Task.first)

   expect(page).to have_content "庭掃除"
   expect(page).to have_content "草刈りをする"

 end
 scenario "タスク詳細のテスト" do
   Task.create!(task_name:"task1",task_body:"tasktask1")

   visit task_path(Task.first)
   #save_and_open_page
   expect(page).to have_content "tasktask1"

 end
end

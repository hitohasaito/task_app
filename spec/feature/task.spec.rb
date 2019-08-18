require 'rails_helper'


RSpec.feature "タスク管理機能", type: :feature do
background do
   FactoryBot.create(:task ,created_at: Time.current+1.days)
   FactoryBot.create(:second_task,created_at: Time.current+3.days)
   FactoryBot.create(:third_task,created_at: Time.current+2.days)
  end

 scenario "タスク一覧のテスト" do
   visit tasks_path

  expect(page).to have_content "tasktask1"
  expect(page).to have_content "tasktask2"
#save_and_open_page

 end

 scenario "タスク作成のテスト" do
   visit new_task_path

   fill_in "task[task_name]", with: "taskname1"
   fill_in "task[task_body]", with: "tasktask1"

   click_button "登録する"

   visit task_path(Task.first)

   expect(page).to have_content "taskname1"
   expect(page).to have_content "tasktask1"
 end

 scenario "タスク詳細のテスト" do

   visit task_path(Task.first)
   expect(page).to have_content "tasktask1"

 end
 scenario "タスク一覧が作成日時で降順に並んでいるかのテスト" do
   visit tasks_path

    def tasks
     expect(page).to have_content "tasktask1"
     expect(page).to have_content "tasktask2"
     expect(page).to have_content "tasktask3"
    end

     tasks{order(created_at: :desc)}
     #save_and_open_page
 end
end

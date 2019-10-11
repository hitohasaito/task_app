require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it "task_nameが空ならバリデーションが通らない" do
     task = Task.new(task_name: '', task_body: '失敗テスト')
     expect(task).not_to be_valid
  end

   it "task_nameとuser_idが記載されていれば詳細が空でもバリデーションが通る" do
     task = Task.create(task_name: "タスク", task_body: "", user_id: @user.id)
     expect(task).to be_valid
   end

   describe "scope" do
     describe "#get_task" do
       it "タスク名が存在していたら、タスク名の値を含む結果を返す" do
         task1 = Task.create(task_name: "taskname1", task_body:"AA", task_status: "未完了", user_id: @user.id )
         expect(Task.get_task("name1")).to include(task1)
       end

      describe "#get_status" do
        it "ステータスが存在していたら、ステータスの値を含む結果を返す" do
          task2 = Task.create(task_name: "taskname2", task_body:"BB", task_status: "着手中", user_id: @user.id)
          expect(Task.get_status("着手中")).to include(task2)
        end
      end
    end
  end
end

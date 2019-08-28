require 'rails_helper'

RSpec.describe Task, type: :model do

  it "task_nameが空ならバリデーションが通らない" do
    task = Task.new(task_name: '', task_body: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "task_nameが記載されていれば詳細が空でもバリデーションが通る" do
    task = Task.new(task_name: '成功テスト', task_body: '')
    expect(task).to be_valid
  end

  describe "scope" do
    describe "get_taskスコープが有効かのテスト" do
      task1 = Task.create(task_name: "taskname1", task_body:"AA", task_status: "未完了")
      it "タスク名が存在していたら、タスク名の値を含む結果を返す" do
        expect(Task.get_task("name1")).to include(task1)
      end
    end

    describe "get_statusスコープが有効かのテスト" do
      task2 = Task.create(task_name: "taskname2", task_body:"BB", task_status: "着手中")
      it "ステータスが存在していたら、ステータスの値を含む結果を返す" do
        expect(Task.get_status("着手中")).to include(task2)
      end
    end
  end
end

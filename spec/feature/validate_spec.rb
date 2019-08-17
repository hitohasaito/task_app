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
end

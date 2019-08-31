class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :task_priority, :integer, null:false, default: 0
  end
end

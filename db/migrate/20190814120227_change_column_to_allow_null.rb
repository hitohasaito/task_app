class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :task_name, :string, null: false
  end

  def down
    change_column :tasks, :task_name, :string, null: true
  end
end

class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column:tasks, :task_status, :integer
  end
end

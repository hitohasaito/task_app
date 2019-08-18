class AddcolumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :task_limit, :datetime, null:false ,default:DateTime.now
  end
end

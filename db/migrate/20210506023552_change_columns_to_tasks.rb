class ChangeColumnsToTasks < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :title, :string, :limit => 100, null:false
    change_column :tasks, :description, :string, :limit => 1000
    change_column :tasks, :status, :string, :limit => 10
    change_column :tasks, :priority, :string, :limit => 10
  end
end

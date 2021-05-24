class ChangeNotNullConstraintToTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :title, :string, :limit => 100, null:false, default: 'タスク'
    change_column :tasks, :status, :string, :limit => 10, null:false, default: '未着手'
  end

  def down
    change_column :tasks, :title, :string, :limit => 100, null:false, default: false
    change_column :tasks, :status, :string, :limit => 10, null:true, default: false
  end
end

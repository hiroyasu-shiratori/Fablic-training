class ChangeUserIdToNullFalse < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :user_id, :int, null:false
  end

  def down
    change_column :tasks, :user_id, :int, null:true
  end
end

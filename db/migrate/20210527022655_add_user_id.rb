class AddUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :user_id, :int, after: :id
  end
end

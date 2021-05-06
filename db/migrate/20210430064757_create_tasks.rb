class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.string :status
      t.string :priority
      t.datetime :deadline

      t.timestamps
    end
  end
end

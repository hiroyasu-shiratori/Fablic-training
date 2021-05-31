class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, :limit => 100, null:false, default: 'ユーザー'

      t.timestamps
    end
  end
end

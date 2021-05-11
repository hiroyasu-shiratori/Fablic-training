class TasksController < ApplicationController
  def index
    @tasks = Task.all

    keys = @tasks.column_names
    vals = ['No', 'タスク名', '詳細', 'ステータス', '優先度', '期限', '作成時間', '更新時間']

    @heading = Hash[keys.zip(vals)]
    @keys = keys
  end
end

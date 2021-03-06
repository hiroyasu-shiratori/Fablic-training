# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @search_params = task_search_params
    @tasks = Task.search(@search_params).includes(:user)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task['user_id'] = 1 # ユーザーのログイン機能を作成していないので、ひとまず1で登録
    if @task.save
      redirect_to root_path, notice: '新しいタスクを作成しました'
    else
      flash.now[:alert] = 'タスクの作成ができませんでした'
      render new_task_path
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: 'タスクを更新しました'
    else
      flash.now[:alert] = 'タスクの更新ができませんでした'
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to root_path, notice: 'タスクを削除しました'
    else
      flash.now[:alert] = 'タスクの削除ができませんでした'
      render :edit
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :deadline)
  end

  def task_search_params
    params.fetch(:search, params).permit(:title, :description, :status, :priority, :deadline)
  end
end

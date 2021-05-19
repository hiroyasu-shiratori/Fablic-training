# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: '新しいタスクを作成しました'
    else
      flash.now[:alert] = 'タスクの作成ができませんでした'
      render :new
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
      render task_path(@task.id)
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to root_path, notice: 'タスクを削除しました'
    else
      flash.now[:alert] = 'タスクの削除ができませんでした'
      render task_path(@task.id)
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :deadline)
  end
end

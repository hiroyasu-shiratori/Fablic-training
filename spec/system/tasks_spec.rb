require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  it 'Automatically create tasks with JS' do
    # Taskの新規作成画面を開く
    visit new_task_path

    # タイトルにtestを入力
    fill_in 'form_title', with: 'test'

    # 説明にタスクの新規作成テストを入力
    fill_in 'form_description', with: 'タスクの新規作成テスト'

    # ステータスを進行中に設定
    find('#form_status').find("option[value='進行中']").select_option

    # 優先度を高に設定
    find('#form_priority').find("option[value='高']").select_option

    # 期限に2023/01/01 17:28を入力
    fill_in 'form_deadline', with: '002023-01-01-17-28'

    # 更新実行
    click_button 'form_submit'

    # 正しく更新されていること（＝画面の表示が正しいこと）を検証する
    expect(page).to have_content 'test'
    expect(page).to have_content '進行中'
    expect(page).to have_content '高'
    expect(page).to have_content '2023-01-01 17:28:00 UTC'
  end

  it 'Automatically update tasks with JS' do
    # 編集前のTaskを作成
    @task = Task.create!(title: '編集前')

    # Taskの編集画面を開く
    visit edit_task_path(@task.id)

    # タイトルに編集後を入力
    fill_in 'form_title', with: '編集後'

    # 更新実行
    click_button 'form_submit'

    # 正しく更新されていること（＝画面の表示が正しいこと）を検証する
    expect(page).to have_content '編集後'
  end
end

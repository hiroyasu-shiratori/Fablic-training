require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe '`タスクの一覧`のテスト' do
    before do
      # 確認用のタスクを作成
      Task.create(title: 'タスク1')
      Task.create(title: 'タスク2')
      # タスクの一覧へ移動
      visit root_path
    end

    it 'ページタイトルの確認' do
      expect(page).to have_title 'タスクの一覧'
    end

    it '全てのタスクが表示されるか確認' do
      expect(page).to have_content 'タスク1'
      expect(page).to have_content 'タスク2'
    end

    it '新規登録へ遷移するか確認' do
      # タスクの新規登録へ遷移する
      click_button 'new_button'
      # 遷移先のタイトルを確認
      expect(page).to have_title 'タスクの新規登録'
    end
  end

  describe '`タスクの新規登録`のテスト' do
    before do
      # タスクの一覧へ移動
      visit new_task_path
    end

    it 'ページタイトルの確認' do
      expect(page).to have_title 'タスクの新規登録'
    end

    it 'タスクが登録できるか確認' do
      # フォームに値を入れる
      fill_in 'form_title', with: '新規登録テスト'
      fill_in 'form_description', with: 'タスクの新規登録テスト'
      find('#form_status').find("option[value='進行中']").select_option
      find('#form_priority').find("option[value='高']").select_option
      fill_in 'form_deadline', with: '002023-01-01-17-28'
      # タスクの登録ボタン
      click_button 'form_submit'
      # 遷移先のタイトルを確認
      expect(page).to have_title 'タスクの一覧'
      # 値が追加されている確認
      expect(page).to have_content '新規登録テスト'
      expect(page).to have_content '進行中'
      expect(page).to have_content '高'
      expect(page).to have_content '2023-01-01 17:28:00 UTC'
    end

    it '入力必須の確認' do
      # タスクの登録ボタン
      click_button 'form_submit'
      # ページが遷移していない事を確認
      expect(page).to have_title 'タスクの新規登録'
    end
  end

  # it 'Automatically update tasks with JS' do
  #   # 編集前のタスクを作成
  #   @task = Task.create(title: '編集前')

  #   # タスクの編集画面を開く
  #   visit edit_task_path(@task.id)

  #   # タイトルに編集後を入力
  #   fill_in 'form_title', with: '編集後'

  #   # 更新実行
  #   click_button 'form_submit'

  #   # 正しく更新されていること（＝画面の表示が正しいこと）を検証する
  #   expect(page).to have_content '編集後'
  # end

  # context 'Automatically destroy tasks with JS' do
  #   it 'test' do
  #     # 編集前のタスクを作成
  #     @task = Task.create(title: '削除テスト')

  #     # タスクの詳細画面を開く
  #     visit task_path(@task.id)

  #     # 削除実行
  #     page.accept_confirm do
  #       click_button 'delete_button'
  #     end

  #     expect(page).to have_current_path root_path

  #     expect(page).to have_selector '.notice', text: 'タスクを削除しました'
  #   end
  # end
end

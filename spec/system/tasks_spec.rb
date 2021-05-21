require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe '`タスクの一覧`のテスト' do
    before do
      # 確認用のタスクを作成
      Task.create(title: '一覧テスト1')
      Task.create(title: '一覧テスト2')
      # タスクの一覧へ遷移
      visit root_path
    end

    it 'ページタイトルの確認' do
      expect(page).to have_title 'タスクの一覧'
    end

    it '全てのタスクが表示されるか確認' do
      expect(page).to have_content '一覧テスト1'
      expect(page).to have_content '一覧テスト2'
    end

    it 'タスクの新規登録へ遷移するか確認' do
      # タスクの新規登録へ遷移する
      click_button 'new_button'
      # 遷移後のpathを確認
      expect(page).to have_current_path new_task_path
    end
  end

  describe '`タスクの新規登録`のテスト' do
    before do
      # タスクの一覧へ遷移
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
      # 遷移後のpathを確認
      expect(page).to have_current_path root_path
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

  describe '`タスクの詳細`のテスト' do
    before do
      # 確認用のタスクを作成
      @task = Task.create(title: '詳細テスト', description: 'タスクの詳細テスト')
      # タスクの詳細へ遷移
      visit task_path(@task.id)
    end

    it 'ページタイトルの確認' do
      expect(page).to have_title 'タスクの詳細'
    end

    it 'タスクの詳細が表示されるか確認' do
      expect(page).to have_content '詳細テスト'
      expect(page).to have_content 'タスクの詳細テスト'
    end

    it 'タスクの詳細へ遷移するか確認' do
      # タスクの新規登録へ遷移する
      click_button 'edit_button'
      # 遷移後のpathを確認
      expect(page).to have_current_path edit_task_path(@task.id)
    end
  end

  describe '`タスクの編集`のテスト' do
    before do
      # 確認用のタスクを作成
      @task = Task.create(title: '編集テスト')
      # タスクの編集へ遷移
      visit edit_task_path(@task.id)
    end

    it 'ページタイトルの確認' do
      expect(page).to have_title 'タスクの編集'
    end

    it 'タスクが編集できるか確認' do
      # フォームに値を入れる
      fill_in 'form_title', with: '編集後のタスク'
      # タスクの編集ボタン
      click_button 'form_submit'
      # 遷移後のpathを確認
      expect(page).to have_current_path task_path(@task.id)
      # 値が追加されている確認
      expect(page).to have_content '編集後のタスク'
    end
  end


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

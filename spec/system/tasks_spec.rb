# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:user) { create(:user) }

  describe '`タスクの一覧`のテスト' do
    # 確認用のタスクを作成
    let!(:task1) { create(:task, title: 'タスク1', user_id: user.id) }
    let!(:task2) { create(:task, title: 'タスク2', status: '未着手', user_id: user.id) }
    let!(:task3) { create(:task, title: 'テスト1', status: '完了', user_id: user.id) }
    let!(:task4) { create(:task, title: 'テスト2', status: '未着手', user_id: user.id) }

    before do
      # タスクの一覧へ遷移
      visit root_path
    end

    it 'ページタイトルの確認' do
      expect(page).to have_title 'タスクの一覧'
    end

    it 'タスクの新規登録へ遷移するか確認' do
      # タスクの新規登録へ遷移する
      click_button 'new_button'
      # 遷移後のpathを確認
      expect(page).to have_current_path new_task_path
    end

    context '表示・検索のテスト' do
      it '絞り込みなしの確認' do
        expect(page).to have_content task1.title
        expect(page).to have_content task2.title
        expect(page).to have_content task3.title
        expect(page).to have_content task4.title
      end

      it 'タイトルをタスクで絞り込み' do
        expect(page).to have_content task1.title
        expect(page).to have_content task2.title
      end

      it 'ステータスを未着手で絞り込み' do
        expect(page).to have_content task2.status
        expect(page).to have_content task4.status
      end

      it 'タイトルをタスク、ステータスを未着手で絞り込み' do
        expect(page).to have_content task2.title
        expect(page).to have_content task2.status
      end
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
      # flashのメッセージを確認
      expect(page).to have_selector '.notice', text: '新しいタスクを作成しました'
      # 値が追加されているか確認
      expect(page).to have_content '新規登録テスト'
      expect(page).to have_content '進行中'
      expect(page).to have_content '高'
      expect(page).to have_content '2023-01-01 17:28:00 UTC'
    end

    it '入力必須の確認' do
      # タイトルの中身を空にする
      fill_in 'form_title', with: ''
      # タスクの登録ボタン
      click_button 'form_submit'
      # ページが遷移していない事を確認
      expect(page).to have_current_path new_task_path
    end

    it '空白文字の確認' do
      # タイトルの中身を空白にする
      fill_in 'form_title', with: ' '
      # タスクの登録ボタン
      click_button 'form_submit'
      # 遷移後のpathを確認
      expect(page).to have_current_path tasks_path
      # flashのメッセージを確認
      expect(page).to have_selector '.alert', text: 'タスクの作成ができませんでした'
    end
  end

  describe '`タスクの詳細`のテスト' do
    # 確認用のタスクを作成
    let(:task) { create(:task, description: 'タスクの詳細テスト', user_id: user.id) }

    before do
      # タスクの詳細へ遷移
      visit task_path(task.id)
    end

    it 'ページタイトルの確認' do
      expect(page).to have_title 'タスクの詳細'
    end

    it 'タスクの詳細が表示されるか確認' do
      expect(page).to have_content task.title
      expect(page).to have_content task.description
    end

    it 'タスクの詳細へ遷移するか確認' do
      # タスクの新規登録へ遷移する
      click_button 'edit_button'
      # 遷移後のpathを確認
      expect(page).to have_current_path edit_task_path(task.id)
    end
  end

  describe '`タスクの編集`のテスト' do
    # 確認用のタスクを作成
    let(:task) { create(:task, user_id: user.id) }

    before do
      # タスクの編集へ遷移
      visit edit_task_path(task.id)
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
      expect(page).to have_current_path task_path(task.id)
      # flashのメッセージを確認
      expect(page).to have_selector '.notice', text: 'タスクを更新しました'
      # 値が編集されているか確認
      expect(page).to have_content '編集後のタスク'
    end

    it '入力必須の確認' do
      # タイトルの中身を空にする
      fill_in 'form_title', with: ''
      # タスクの登録ボタン
      click_button 'form_submit'
      # ページが遷移していない事を確認
      expect(page).to have_current_path edit_task_path(task.id)
    end

    it '空白文字の確認' do
      # タイトルの中身を空白にする
      fill_in 'form_title', with: ' '
      # タスクの登録ボタン
      click_button 'form_submit'
      # 遷移後のpathを確認
      expect(page).to have_current_path task_path(task.id)
      # flashのメッセージを確認
      expect(page).to have_selector '.alert', text: 'タスクの更新ができませんでした'
    end
  end

  describe '`タスクの削除`のテスト' do
    # 確認用のタスクを作成
    let(:task) { create(:task, user_id: user.id) }

    before do
      # タスクの詳細へ遷移
      visit task_path(task.id)
    end

    it 'タスクが削除できるか確認' do
      # タスクの削除でokを押す
      page.accept_confirm do
        click_button 'delete_button'
      end
      # 遷移後のpathを確認
      expect(page).to have_current_path root_path
      # flashのメッセージを確認
      expect(page).to have_selector '.notice', text: 'タスクを削除しました'
    end

    it 'タスクの削除をキャンセルできるか確認' do
      # タスクの削除でキャンセルを押す
      page.dismiss_confirm do
        click_button 'delete_button'
      end
      # ページが遷移していない事を確認
      expect(page).to have_current_path task_path(task.id)
    end
  end
end

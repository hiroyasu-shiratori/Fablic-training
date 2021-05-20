require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  # before do
  #   @user = User.create!(name: 'いとう')
  # end

  it 'Automatically create tasks with JS' do
    # Taskの新規作成画面を開く
    visit new_task_path

    # タイトルにtestを入力
    fill_in 'form_title', with: 'test'


    # # 更新実行
    # click_button 'Update User'

    # # 正しく更新されていること（＝画面の表示が正しいこと）を検証する
    # expect(page).to have_content 'User was successfully updated.'
    # expect(page).to have_content 'いとう'
    # expect(page).to have_content '158-0083'
    # expect(page).to have_content '東京都世田谷区奥沢'
  end
end

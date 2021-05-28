# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }

  describe '`title`のバリデーションをテスト' do
    let(:task) { build(:task, title: title, user_id: user.id) }

    context '`title`が100文字の場合' do
      let(:title) { 'A' * 100 }
      it '有効' do
        expect(task).to be_valid
      end
    end

    context '`title`が101文字の場合' do
      let(:title) { 'A' * 101 }
      it '無効' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to contain_exactly('Title is too long (maximum is 100 characters)')
      end
    end

    context '`title`が0文字の場合' do
      let(:title) { 'A' * 0 }
      it '無効' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to contain_exactly("Title can't be blank")
      end
    end
  end

  describe '`description`のバリデーションをテスト' do
    let(:task) { build(:task, description: description, user_id: user.id) }

    context '`description`が1000文字の場合' do
      let(:description) { 'A' * 1000 }
      it '有効' do
        expect(task).to be_valid
      end
    end

    context '`description`が1001文字の場合' do
      let(:description) { 'A' * 1001 }
      it '無効' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to contain_exactly('Description is too long (maximum is 1000 characters)')
      end
    end

    context '`description`が0文字の場合' do
      let(:description) { 'A' * 0 }
      it '有効' do
        expect(task).to be_valid
      end
    end
  end

  describe '`status`のバリデーションをテスト' do
    let(:task) { build(:task, status: status, user_id: user.id) }

    context '`status`が未着手の場合' do
      let(:status) { '未着手' }
      it '有効' do
        expect(task).to be_valid
      end
    end

    context '`status`が進行中の場合' do
      let(:status) { '進行中' }
      it '有効' do
        expect(task).to be_valid
      end
    end

    context '`status`が完了の場合' do
      let(:status) { '完了' }
      it '有効' do
        expect(task).to be_valid
      end
    end

    context '`status`が関係ない文字の場合' do
      let(:status) { 'A' * 20 }
      it '無効' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to contain_exactly(
          'Status is not included in the list',
          'Status is too long (maximum is 10 characters)'
        )
      end
    end

    context '`status`が空文字の場合' do
      let(:status) { '' }
      it '無効' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to contain_exactly(
          "Status can't be blank",
          'Status is not included in the list'
        )
      end
    end
  end

  describe '`priority`のバリデーションをテスト' do
    let(:task) { build(:task, priority: priority, user_id: user.id) }

    context '`priority`が高の場合' do
      let(:priority) { '高' }
      it '有効' do
        expect(task).to be_valid
      end
    end

    context '`priority`が中の場合' do
      let(:priority) { '中' }
      it '有効' do
        expect(task).to be_valid
      end
    end

    context '`priority`が低の場合' do
      let(:priority) { '低' }
      it '有効' do
        expect(task).to be_valid
      end
    end

    context '`priority`が関係ない文字の場合' do
      let(:priority) { 'A' * 20 }
      it '無効' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to contain_exactly(
          'Priority is not included in the list',
          'Priority is too long (maximum is 10 characters)'
        )
      end
    end
  end
end

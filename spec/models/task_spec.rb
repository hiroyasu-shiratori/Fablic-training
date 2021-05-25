# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '`title`のバリデーションをテスト' do
    let(:task) { build(:task, title: title) }

    context '`title`が100文字の場合、有効' do
      let(:title) { 'A' * 100 }
      it do
        expect(task).to be_valid
      end
    end

    context '`title`が101文字の場合、無効' do
      let(:title) { 'A' * 101 }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array('Title is too long (maximum is 100 characters)')
      end
    end

    context '`title`が0文字の場合、無効' do
      let(:title) { 'A' * 0 }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array("Title can't be blank")
      end
    end
  end

  describe '`description`のバリデーションをテスト' do
    let(:task) { build(:task, description: description) }

    context '`description`が1000文字の場合、有効' do
      let(:description) { 'A' * 1000 }
      it do
        expect(task).to be_valid
      end
    end

    context '`description`が1001文字の場合、無効' do
      let(:description) { 'A' * 1001 }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array('Description is too long (maximum is 1000 characters)')
      end
    end

    context '`description`が0文字の場合、有効' do
      let(:description) { 'A' * 0 }
      it do
        expect(task).to be_valid
      end
    end
  end

  describe '`status`のバリデーションをテスト' do
    let(:task) { build(:task, status: status) }

    context '`status`が10文字の場合、有効' do
      let(:status) { 'A' * 10 }
      it do
        expect(task).to be_valid
      end
    end

    context '`status`が11文字の場合、無効' do
      let(:status) { 'A' * 11 }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array('Status is too long (maximum is 10 characters)')
      end
    end

    context '`status`が0文字の場合、無効' do
      let(:status) { 'A' * 0 }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array("Status can't be blank")
      end
    end
  end

  describe '`priority`のバリデーションをテスト' do
    let(:task) { build(:task, priority: priority) }

    context '`priority`が10文字の場合、有効' do
      let(:priority) { 'A' * 10 }
      it do
        expect(task).to be_valid
      end
    end

    context '`priority`が11文字の場合、無効' do
      let(:priority) { 'A' * 11 }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array('Priority is too long (maximum is 10 characters)')
      end
    end

    context '`priority`が0文字の場合、有効' do
      let(:priority) { 'A' * 0 }
      it do
        expect(task).to be_valid
      end
    end
  end

  describe '`deadline`のバリデーションをテスト' do
    context '`deadline`が`2023-01-01 17:28:00 UT`の場合、有効'
    context '`deadline`が`2023-01-01 17:28:00 UT`でない場合、無効'
  end
end
